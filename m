Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35541 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdGOVU5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 15 Jul 2017 17:20:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id u23so16610745wma.2
        for <util-linux@vger.kernel.org>; Sat, 15 Jul 2017 14:20:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/5] docs: add optional option back to struct option
Date: Sat, 15 Jul 2017 22:20:44 +0100
Message-Id: <20170715212046.1655-4-kerolasa@iki.fi>
In-Reply-To: <20170715212046.1655-1-kerolasa@iki.fi>
References: <20170715212046.1655-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The line was accidentally removed in the reference commit where only the
short option had to go.  Rest of the change is indentation.

Reference: 326c5c93b917a623f346155c8b3438b379d9fd60
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/boilerplate.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/boilerplate.c b/Documentation/boilerplate.c
index 68ffbf7ea..a92f7f097 100644
--- a/Documentation/boilerplate.c
+++ b/Documentation/boilerplate.c
@@ -69,14 +69,15 @@ int main(int argc, char **argv)
 		OPT_OPTIONAL	/* see howto-man-page.txt about short option */
 	};
 	static const struct option longopts[] = {
-		{ "no-argument",                no_argument,       NULL, 'n'       },
-		{ "required",                   required_argument, NULL, 'r'       },
-		{ "extremely-long-long-option", no_argument,       NULL, 'e'       },
-		{ "xyzzy",                      no_argument,       NULL, OPT_XYZZY },
-		{ "long-explanation",           no_argument,       NULL, 'l'       },
-		{ "foobar",                     no_argument,       NULL, 'f'       },
-		{ "version",                    no_argument,       NULL, 'V'       },
-		{ "help",                       no_argument,       NULL, 'h'       },
+		{ "no-argument",                no_argument,       NULL, 'n'          },
+		{ "optional",                   optional_argument, NULL, OPT_OPTIONAL },
+		{ "required",                   required_argument, NULL, 'r'          },
+		{ "extremely-long-long-option", no_argument,       NULL, 'e'          },
+		{ "xyzzy",                      no_argument,       NULL, OPT_XYZZY    },
+		{ "long-explanation",           no_argument,       NULL, 'l'          },
+		{ "foobar",                     no_argument,       NULL, 'f'          },
+		{ "version",                    no_argument,       NULL, 'V'          },
+		{ "help",                       no_argument,       NULL, 'h'          },
 		{ NULL, 0, NULL, 0 }
 	};
 
-- 
2.13.3

