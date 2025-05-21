# frozen_string_literal: true

Deface::Override.new(virtual_path: "layouts/decidim/header/_main_links_desktop",
                     name: "authentication_flow_setup",
                     insert_before: "div:has(erb[loud]:contains('decidim.new_user_session_path'))",
                     text: <<~ERB
                       <%#{" "}
                        antispam_authentication_flow = Decidim::SpamSignal::AuthenticationValidationForm.new.with_context(
                            current_organization: current_organization
                         )
                         antispam_authentication_flow.validate
                        %>
                     ERB
                    )

Deface::Override.new(virtual_path: "layouts/decidim/header/_main_links_desktop",
                     name: "authentication_flow_hide",
                     set_attributes: "div:has(erb[loud]:contains('decidim.new_user_session_path'))",
                     attributes: { class: "<%= antispam_authentication_flow.errors.empty? ? 'spam-signal-valid' : 'spam-signal-invalid hidden' %>" })

Deface::Override.new(virtual_path: "layouts/decidim/header/_main_links_desktop",
                     name: "authentication_flow_message",
                     insert_after: "div:has(erb[loud]:contains('decidim.new_user_session_path'))",
                     text: <<~ERB
                       <span class="form-error is-visible"><%= antispam_authentication_flow.errors.empty? ? '' : antispam_authentication_flow.errors.full_messages.join(', ') %></span>
                     ERB
                    )

Deface::Override.new(virtual_path: "layouts/decidim/header/_main_links_mobile_item_account",
                     name: "authentication_flow_setup_mobile",
                     surround: "erb[loud]:contains('decidim.new_user_session_path')",
                     closing_selector: "erb[silent]:contains('end')",
                     text: <<~ERB
                       <%#{" "}
                        antispam_authentication_flow = Decidim::SpamSignal::AuthenticationValidationForm.new.with_context(
                            current_organization: current_organization
                         )
                         antispam_authentication_flow.validate
                        %>
                        <% if antispam_authentication_flow.errors.empty? %>
                          <%= render_original %>
                        <% else %>
                          <span class="form-error is-visible"><%= antispam_authentication_flow.errors.full_messages.join(', ') %></span>
                        <% end %>
                     ERB
                    )

Deface::Override.new(virtual_path: "layouts/decidim/footer/_main_links",
                     name: "authentication_flow_footer_setup",
                     insert_after: "erb[loud]:contains('footer_menu.render')",
                     text: <<~ERB
                       <%#{" "}
                        antispam_authentication_flow = Decidim::SpamSignal::AuthenticationValidationForm.new.with_context(
                            current_organization: current_organization
                         )
                         antispam_authentication_flow.validate
                        %>
                     ERB
                    )

Deface::Override.new(virtual_path: "layouts/decidim/footer/_main_links",
                     name: "authentication_flow_footer_signin",
                     set_attributes: "li:has(erb[loud]:contains('decidim.new_user_session_path'))",
                     attributes: { class: "<%= antispam_authentication_flow.errors.empty? ? 'spam-signal-valid' : 'spam-signal-invalid hidden' %>" })

Deface::Override.new(virtual_path: "layouts/decidim/footer/_main_links",
                     name: "authentication_flow_footer_footer_header",
                     set_attributes: "erb[loud]:contains('layouts.decidim.user_menu.profile')",
                     attributes: { class: "<%= antispam_authentication_flow.errors.empty? ? 'spam-signal-valid' : 'spam-signal-invalid hidden' %>" })

Deface::Override.new(virtual_path: "layouts/decidim/footer/_main_links",
                     name: "authentication_flow_footer_signup",
                     set_attributes: "li:has(erb[loud]:contains('decidim.new_user_registration_path'))",
                     attributes: { class: "<%= antispam_authentication_flow.errors.empty? ? 'spam-signal-valid' : 'spam-signal-invalid hidden' %>" })
