Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:49704 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbaLHLhO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Dec 2014 06:37:14 -0500
Received: by mail-wi0-f170.google.com with SMTP id bs8so6832588wib.5
        for <util-linux@vger.kernel.org>; Mon, 08 Dec 2014 03:37:13 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1417947235-24229-11-git-send-email-kerolasa@iki.fi>
References: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
	<1417947235-24229-11-git-send-email-kerolasa@iki.fi>
Date: Mon, 8 Dec 2014 11:37:12 +0000
Message-ID: <CAG27Bk2KiL7C04p3ALBVNhKdks=idyiGiJ3gPzQhT10txUTM3g@mail.gmail.com>
Subject: Re: [PATCH 11/11] getopt: avoid re-terminating long_option list at
 every update
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Cc: Sami Kerola <kerolasa@iki.fi>,
        Frodo Looijaard <frodo@frodo.looijaard.name>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 7 December 2014 at 10:13, Sami Kerola <kerolasa@iki.fi> wrote:
[snip]
> diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
[snip]
> @@ -290,9 +283,14 @@ static void add_long_options(struct getopt_control *ctl, char *options)
>                                                      "-l or --long argument"));
>                         }
>                         add_longopt(ctl, tokptr, arg_opt);
> +                       ctl->long_options_nr++;
>                 }
>                 tokptr = strtok(NULL, ", \t\n");
>         }
> +       ctl->long_options[ctl->long_options_nr].name = NULL;
> +       ctl->long_options[ctl->long_options_nr].has_arg = 0;
> +       ctl->long_options[ctl->long_options_nr].flag = NULL;
> +       ctl->long_options[ctl->long_options_nr].val = 0;
>  }
>
>  static shell_t shell_type(const char *new_shell)
> --
> 2.1.3

Sorry Karel, the submission was incorrect. With the change I sent
add_long_options() could overflow. Here is fix to the issue.

@@ -290,9 +283,15 @@ static void add_long_options(struct
getopt_control *ctl, char *options)
                                                     "-l or --long argument"));
                        }
                        add_longopt(ctl, tokptr, arg_opt);
+                       ctl->long_options_nr++;
                }
                tokptr = strtok(NULL, ", \t\n");
        }
+       add_longopt(&ctl, NULL, 0);     /* ensure long_options[] is not full */
+       ctl->long_options[ctl->long_options_nr].name = NULL;
+       ctl->long_options[ctl->long_options_nr].has_arg = 0;
+       ctl->long_options[ctl->long_options_nr].flag = NULL;
+       ctl->long_options[ctl->long_options_nr].val = 0;
 }

Also available from:

https://github.com/kerolasa/lelux-utiliteetit/commit/9ddfa7e4a7e3e1936688596e14c1632a034b733e

or if you want I can re-submit the patch when I am not in office
network (that has 'lets make life impossible' firewall design).

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
