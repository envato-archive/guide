require 'rails_helper'

RSpec.describe Guide::Diplomat do
  let(:diplomat) { described_class.new(session, params, default_locale) }
  let!(:session) do
    {
      :guide_locale => session_locale,
    }.delete_if { |key, value| value.blank? }
  end
  let!(:params) do
    {
      :locale => new_locale,
      :temp_locale => temp_locale,
    }.delete_if { |key, value| value.blank? }
  end
  let(:default_locale) { 'en' }
  let(:new_locale) { nil }
  let(:temp_locale) { nil }
  let(:session_locale) { nil }

  before do
    allow(Guide.configuration).to receive(:supported_locales).and_return(supported_locales)
  end

  describe '#negotiate_locale' do
    subject(:negotiate_locale) { diplomat.negotiate_locale }

    let(:supported_locales) do
      {
        "English" => "en",
        "Portuguese" => "pt",
        "Russian" => "ru",
        "Spanish" => "es",
      }
    end

    context 'given that there is a new locale in the params' do
      context 'and the new locale is supported' do
        let(:new_locale) { "pt" }

        context 'and the params do not have a temporary locale' do
          let(:temp_locale) { nil }

          it "returns the new locale" do
            expect(negotiate_locale).to eq new_locale
          end

          it "stores the new locale in the session" do
            negotiate_locale

            expect(session[:guide_locale]).to eq new_locale
          end
        end

        context 'but the params have a temporary locale' do
          context 'and the temporary locale is supported' do
            let(:temp_locale) { "ru" }

            it "stores the new locale in the session" do
              negotiate_locale

              expect(session[:guide_locale]).to eq new_locale
            end

            it "returns the temporary locale" do
              expect(negotiate_locale).to eq temp_locale
            end
          end

          context 'but the temporary locale is not supported' do
            let(:temp_locale) { "unsupported" }

            it "stores the new locale in the session" do
              negotiate_locale

              expect(session[:guide_locale]).to eq new_locale
            end

            it "returns the new locale" do
              expect(negotiate_locale).to eq new_locale
            end
          end
        end
      end

      context 'but the new locale is not supported' do
        let(:new_locale) { "unsupported" }

        context 'and the params do not have a temporary locale' do
          let(:temp_locale) { nil }

          context 'but there is a locale already in the session' do
            context 'and the session locale is supported' do
              let(:session_locale) { 'es' }

              it "returns the session locale" do
                expect(negotiate_locale).to eq session_locale
              end

              it "does not store a new locale in the session" do
                negotiate_locale

                expect(session[:guide_locale]).to eq session_locale
              end
            end

            context 'but the session locale is not supported any more' do
              let(:session_locale) { 'unsupported' }

              it "returns the default locale" do
                expect(negotiate_locale).to eq default_locale
              end

              it "clears the session locale" do
                negotiate_locale

                expect(session[:guide_locale]).to be nil
              end
            end
          end
        end

        context 'but the params have a temporary locale' do
          context 'and the temporary locale is supported' do
            let(:temp_locale) { "ru" }

            it "returns the temporary locale" do
              expect(negotiate_locale).to eq temp_locale
            end

            it "does not store a new locale in the session" do
              negotiate_locale

              expect(session[:guide_locale]).to eq session_locale
            end
          end

          context 'but the temporary locale is not supported' do
            let(:temp_locale) { "unsupported" }

            it "returns the default locale" do
              expect(negotiate_locale).to eq default_locale
            end

            it "does not store a new locale in the session" do
              negotiate_locale

              expect(session[:guide_locale]).to eq session_locale
            end
          end
        end
      end
    end

    context 'given that the params do not have a new locale' do
      context 'and the params do not have a temporary locale' do
        let(:temp_locale) { nil }

        context 'but there is a locale already in the session' do
          context 'and the session locale is supported' do
            let(:session_locale) { 'es' }

            it "returns the session locale" do
              expect(negotiate_locale).to eq session_locale
            end

            it "does not store a new locale in the session" do
              negotiate_locale

              expect(session[:guide_locale]).to eq session_locale
            end
          end

          context 'but the session locale is not supported any more' do
            let(:session_locale) { 'unsupported' }

            it "returns the default locale" do
              expect(negotiate_locale).to eq default_locale
            end

            it "clears the session locale" do
              negotiate_locale

              expect(session[:guide_locale]).to be nil
            end
          end
        end
      end

      context 'but the params have a temporary locale' do
        context 'and the temporary locale is supported' do
          let(:temp_locale) { "ru" }

          it "returns the temporary locale" do
            expect(negotiate_locale).to eq temp_locale
          end

          it "does not store a new locale in the session" do
            negotiate_locale

            expect(session[:guide_locale]).to eq session_locale
          end
        end

        context 'but the temporary locale is not supported' do
          let(:temp_locale) { "unsupported" }

          it "returns the default locale" do
            expect(negotiate_locale).to eq default_locale
          end

          it "does not store a new locale in the session" do
            negotiate_locale

            expect(session[:guide_locale]).to eq session_locale
          end
        end
      end
    end
  end

  describe '#multiple_supported_locales?' do
    subject(:multiple_supported_locales?) { diplomat.multiple_supported_locales? }

    context 'given that there is only one supported locale' do
      let(:supported_locales) do
        {
          "English" => "en",
        }
      end

      it { is_expected.to be false }
    end

    context 'given that there are many supported locales' do
      let(:supported_locales) do
        {
          "English" => "en",
          "Portuguese" => "pt",
          "Russian" => "ru",
          "Spanish" => "es",
        }
      end

      it { is_expected.to be true }
    end

    context "given that for some reason we don't support any locales" do
      let(:supported_locales) { {} }

      it { is_expected.to be false }
    end
  end

  describe '#current_locale' do
    subject(:current_locale) { diplomat.current_locale }

    let(:supported_locales) do
      {
        "English" => "en",
        "Portuguese" => "pt",
        "Russian" => "ru",
        "Spanish" => "es",
      }
    end

    context 'given that the session has a locale stored' do
      context 'and the locale in the session is supported' do
        let(:session_locale) { "ru" }

        it 'returns the locale from the session' do
          expect(current_locale).to eq session_locale
        end
      end

      context 'but the locale in the session is no longer supported' do
        let(:session_locale) { "unsupported" }

        it 'clears the locale from the session' do
          current_locale

          expect(session[:guide_locale]).to be nil
        end

        it 'returns the default locale' do
          expect(current_locale).to eq default_locale
        end
      end
    end

    context 'given that the session does not have a locale stored' do
      let(:session_locale) { nil }

      it 'returns the default locale' do
        expect(current_locale).to eq default_locale
      end
    end
  end
end
