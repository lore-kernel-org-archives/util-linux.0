Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:40164 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533AbaLHUFn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Dec 2014 15:05:43 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so5779298wiv.12
        for <util-linux@vger.kernel.org>; Mon, 08 Dec 2014 12:05:42 -0800 (PST)
Date: Mon, 8 Dec 2014 20:05:30 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
cc: Frodo Looijaard <frodo@frodo.looijaard.name>
Subject: Re: [PATCH 11/11] getopt: avoid re-terminating long_option list at
 every update
In-Reply-To: <CAG27Bk2KiL7C04p3ALBVNhKdks=idyiGiJ3gPzQhT10txUTM3g@mail.gmail.com>
Message-ID: <alpine.LNX.2.03.1412082004001.8079@iki.fi>
References: <1417947235-24229-1-git-send-email-kerolasa@iki.fi> <1417947235-24229-11-git-send-email-kerolasa@iki.fi> <CAG27Bk2KiL7C04p3ALBVNhKdks=idyiGiJ3gPzQhT10txUTM3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 8 Dec 2014, Sami Kerola wrote:
> Sorry Karel, the submission was incorrect. With the change I sent 
> add_long_options() could overflow. Here is fix to the issue.
[snip]
> or if you want I can re-submit the patch when I am not in office

Here is the resubmission I promised.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 7 Dec 2014 09:55:08 +0000
Subject: [PATCH] getopt: avoid re-terminating long_option list at every update

Terminating the ctl->long_options list once when adding options is
completed is enough.  This also allows moving ctl->long_options_nr
increment to more appropriate location.

CC: Frodo Looijaard <frodo@frodo.looijaard.name>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
  misc-utils/getopt.c | 21 ++++++++++-----------
  1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 2940a7d..7f26792 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -248,20 +248,13 @@ static void add_longopt(struct getopt_control *ctl, const char *name, int has_ar
  					     sizeof(struct option) *
  					     ctl->long_options_length);
  	}
-
-	ctl->long_options[ctl->long_options_nr].name = NULL;
-	ctl->long_options[ctl->long_options_nr].has_arg = 0;
-	ctl->long_options[ctl->long_options_nr].flag = NULL;
-	ctl->long_options[ctl->long_options_nr].val = 0;
-
  	if (name) {
  		/* Not for init! */
-		ctl->long_options[ctl->long_options_nr - 1].has_arg = has_arg;
-		ctl->long_options[ctl->long_options_nr - 1].flag = &flag;
-		ctl->long_options[ctl->long_options_nr - 1].val = ctl->long_options_nr;
-		ctl->long_options[ctl->long_options_nr - 1].name = xstrdup(name);
+		ctl->long_options[ctl->long_options_nr].has_arg = has_arg;
+		ctl->long_options[ctl->long_options_nr].flag = &flag;
+		ctl->long_options[ctl->long_options_nr].val = ctl->long_options_nr;
+		ctl->long_options[ctl->long_options_nr].name = xstrdup(name);
  	}
-	ctl->long_options_nr++;
  }


@@ -290,9 +283,15 @@ static void add_long_options(struct getopt_control *ctl, char *options)
  						     "-l or --long argument"));
  			}
  			add_longopt(ctl, tokptr, arg_opt);
+			ctl->long_options_nr++;
  		}
  		tokptr = strtok(NULL, ", \t\n");
  	}
+	add_longopt(&ctl, NULL, 0);	/* ensure long_options[] is not full */
+	ctl->long_options[ctl->long_options_nr].name = NULL;
+	ctl->long_options[ctl->long_options_nr].has_arg = 0;
+	ctl->long_options[ctl->long_options_nr].flag = NULL;
+	ctl->long_options[ctl->long_options_nr].val = 0;
  }

  static shell_t shell_type(const char *new_shell)
-- 
2.1.3

