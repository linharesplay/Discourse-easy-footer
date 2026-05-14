import Component from "@glimmer/component";
import { htmlSafe } from "@ember/template";
import { service } from "@ember/service";
import PluginOutlet from "discourse/components/plugin-outlet";
import concatClass from "discourse/helpers/concat-class";
import icon from "discourse/helpers/d-icon";
import dasherize from "discourse/helpers/dasherize";
import i18n from "discourse-common/helpers/i18n";

export default class extends Component {
  @service siteSettings;

  logoUrl = settings.logo_url;
  googlePlayStoreUrl = settings.google_play_store_url;

  get blurb() {
    return themePrefix("blurb");
  }

  get googlePlayButtonText() {
    return themePrefix("google_play_button_text");
  }

  get showGooglePlayButton() {
    return this.googlePlayStoreUrl && this.googlePlayStoreUrl.trim() !== "";
  }

  get logoStyle() {
    if (!this.logoUrl) {
      return null;
    }
    return htmlSafe(`--footer-logo-url: url("${this.logoUrl}");`);
  }

  get sections() {
    return settings.sections.map((section, sectionIndex) => ({
      ...section,
      translatedText: themePrefix(`sections.section_${sectionIndex}.text`),
      translatedTitle: themePrefix(`sections.section_${sectionIndex}.title`),
      links: section.links.map((link, linkIndex) => ({
        ...link,
        translatedText: themePrefix(`sections.section_${sectionIndex}.links.link_${linkIndex}.text`),
        translatedTitle: themePrefix(`sections.section_${sectionIndex}.links.link_${linkIndex}.title`),
      })),
    }));
  }

  get smallLinks() {
    return settings.small_links.map((link, index) => ({
      ...link,
      translatedText: themePrefix(`small_links.link_${index}.text`),
    }));
  }

  get socialLinks() {
    return settings.social_links.map((link, index) => ({
      ...link,
      translatedTitle: themePrefix(`social_links.link_${index}.title`),
    }));
  }

  <template>
    <div class="wrap">
        <div class="flexbox">
          <div class="first-box">
            {{#if this.logoUrl}}
              <div
                class="footer-logo"
                role="img"
                aria-label="Gamer Nation"
                style={{this.logoStyle}}
              ></div>
            {{/if}}
            <div class="blurb">
              {{i18n this.blurb}}
            </div>
          </div>
          <div class="second-box">
            <PluginOutlet @name="easy-footer-second-box">
              <div class="links">
                {{#each this.sections as |section|}}
                  <div
                    class="list"
                    data-easyfooter-section={{dasherize section.text}}
                  >
                    <span title={{i18n section.translatedTitle}}>
                      {{i18n section.translatedText}}
                    </span>

                    <ul>
                      {{#each section.links as |link|}}
                        <li
                          class="footer-section-link-wrapper"
                          data-easyfooter-link={{dasherize link.text}}
                        >
                          <a
                            class="footer-section-link"
                            title={{i18n link.translatedTitle}}
                            href={{link.url}}
                            target={{link.target}}
                            referrerpolicy={{link.referrer_policy}}
                          >
                            {{i18n link.translatedText}}
                          </a>
                        </li>
                      {{/each}}
                    </ul>
                  </div>
                {{/each}}

                {{#if this.showGooglePlayButton}}
                  <div class="list google-play-column">
                    <a
                      class="google-play-button"
                      href={{this.googlePlayStoreUrl}}
                      target="_blank"
                      rel="noopener noreferrer"
                      title={{i18n this.googlePlayButtonText}}
                    >
                      {{icon "fab-google-play"}}
                      <span>{{i18n this.googlePlayButtonText}}</span>
                    </a>
                  </div>
                {{/if}}
              </div>
            </PluginOutlet>
          </div>

          <div class="third-box">
            <div class="footer-links">
              {{#each this.smallLinks as |link|}}
                <a
                  class={{concatClass "small-link" link.css_class}}
                  data-easyfooter-small-link={{dasherize link.text}}
                  target={{link.target}}
                  href={{link.url}}
                >
                  {{i18n link.translatedText}}
                </a>
              {{/each}}
            </div>

            <div class="social">
              {{#each this.socialLinks as |link|}}
                <a
                  class="social-link"
                  data-easyfooter-social-link={{dasherize link.text}}
                  title={{i18n link.translatedTitle}}
                  target={{link.target}}
                  href={{link.url}}
                >
                  {{icon link.icon_name}}
                </a>
              {{/each}}
            </div>
          </div>
        </div>
      </div>
  </template>
}
