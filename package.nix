{
  pkgs,
  lib,
  jq,
  curl,
  ...
}: let
  inherit (pkgs.lib.meta) getExe' getExe;
in
  pkgs.writeShellScriptBin "memo" ''
    #!/bin/sh

    JQ=${getExe jq}
    CURL=${getExe curl}

    CONF_PATH=~/.config/memo/config
    NOTION_INTEGRATION_URL="https://www.notion.so/profile/integrations/form/new-integration"

    if [ ! -e "$CONF_PATH" ] ; then
      read -p "Do you want to open this URL in your browser? [y/N]: $NOTION_INTEGRATION_URL " confirm
      if [[ -z "$confirm" || "$confirm" =~ ^[Yy]$ ]]; then
        xdg-open "$NOTION_INTEGRATION_URL" >/dev/null 2>&1 &
        read -p "Enter NOTION_INTERNAL_SECRET:" NOTION_INTERNAL_SECRET
        mkdir -p "$(dirname "$CONF_PATH")"
        echo "NOTION_INTERNAL_SECRET=$NOTION_INTERNAL_SECRET" >> "$CONF_PATH"

        echo
        read -p "Enter NOTION_DATABASE_ID:" NOTION_DATABASE_ID
        echo "NOTION_DATABASE_ID=$NOTION_DATABASE_ID" >> "$CONF_PATH"
      else
        echo "Cancelled."
        exit
      fi

    fi

    #shellcheck disable=SC1090
    . $CONF_PATH

    BODY=$($JQ -n \
       --arg database_id "$NOTION_DATABASE_ID" \
       --arg content "$1" \
           '{parent: {database_id: $database_id}, properties: {title:{title:[{text:{content: $content}}]}}}'
    )

    RESP=$($CURL --silent -X POST \
       -H "Content-Type: application/json" \
       -H "Authorization: Bearer $NOTION_INTERNAL_SECRET" \
       -H "Notion-Version: 2021-08-16" --data "$BODY" https://api.notion.com/v1/pages)

    xdg-open "$(echo "$RESP" | $JQ -r '.url')" >/dev/null 2>&1 &
  ''
