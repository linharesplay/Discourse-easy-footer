import Component from "@glimmer/component";
import { htmlSafe } from "@ember/template";
import PluginOutlet from "discourse/components/plugin-outlet";
import concatClass from "discourse/helpers/concat-class";
import icon from "discourse/helpers/d-icon";
import dasherize from "discourse/helpers/dasherize";

export default class extends Component {
  blurb = settings.blurb;
  logoUrl = settings.logo_url;
  googlePlayStoreUrl = settings.google_play_store_url;
  googlePlayButtonText = settings.google_play_button_text;

  get showGooglePlayButton() {
    return this.googlePlayStoreUrl && this.googlePlayStoreUrl.trim() !== "";
  }

  get logoStyle() {
    if (!this.logoUrl) {
      return null;
    }
    return htmlSafe(`--footer-logo-url: url("${this.logoUrl}");`);
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
              {{this.blurb}}
            </div>
          </div>
          <div class="second-box">
            <PluginOutlet @name="easy-footer-second-box">
              <div class="links">
                {{#each settings.sections as |section|}}
                  <div
                    class="list"
                    data-easyfooter-section={{dasherize section.text}}
                  >
                    <span title={{section.title}}>
                      {{section.text}}
                    </span>

                    <ul>
                      {{#each section.links as |link|}}
                        <li
                          class="footer-section-link-wrapper"
                          data-easyfooter-link={{dasherize link.text}}
                        >
                          <a
                            class="footer-section-link"
                            title={{link.title}}
                            href={{link.url}}
                            target={{link.target}}
                            referrerpolicy={{link.referrer_policy}}
                          >
                            {{link.text}}
                          </a>
                        </li>
                      {{/each}}
                    </ul>
                  </div>
                {{/each}}
              </div>
            </PluginOutlet>
          </div>

          <div class="third-box">
            <div class="footer-links">
              {{#each settings.small_links as |link|}}
                <a
                  class={{concatClass "small-link" link.css_class}}
                  data-easyfooter-small-link={{dasherize link.text}}
                  target={{link.target}}
                  href={{link.url}}
                >
                  {{link.text}}
                </a>
              {{/each}}
            </div>

            <div class="social">
              {{#each settings.social_links as |link|}}
                <a
                  class="social-link"
                  data-easyfooter-social-link={{dasherize link.text}}
                  title={{link.title}}
                  target={{link.target}}
                  href={{link.url}}
                >
                  {{icon link.icon_name}}
                </a>
              {{/each}}
            </div>

            {{#if this.showGooglePlayButton}}
              <a
                class="google-play-button"
                href={{this.googlePlayStoreUrl}}
                target="_blank"
                rel="noopener noreferrer"
                title={{this.googlePlayButtonText}}
              >
                {{icon "fab-google-play"}}
                <span>{{this.googlePlayButtonText}}</span>
              </a>
            {{/if}}
          </div>
        </div>
      </div>
  </template>
}
