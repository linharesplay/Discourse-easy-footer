import hideApplicationFooter from "discourse/helpers/hide-application-footer";

// Template-only component for minimal overhead
<template>
  {{#unless settings.show_footer_on_login_required_page}}
    {{hideApplicationFooter}}
  {{/unless}}
</template>
