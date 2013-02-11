Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f181.google.com ([209.85.128.181]:36498 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758414Ab3BKXEM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 11 Feb 2013 18:04:12 -0500
Received: by mail-ve0-f181.google.com with SMTP id d10so5592690vea.40
        for <util-linux@vger.kernel.org>; Mon, 11 Feb 2013 15:04:12 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <BLU0-SMTP144C815AE93C94E539C372CD50A0@phx.gbl>
References: <BLU0-SMTP36414270EB979DF67318E53D50B0@phx.gbl>
	<CAG27Bk2XQxWUFZPuQP8JWJaJ5OuCrxspk==9saGO-Xv6yk=7Sg@mail.gmail.com>
	<BLU0-SMTP144C815AE93C94E539C372CD50A0@phx.gbl>
Date: Mon, 11 Feb 2013 22:56:22 +0000
Message-ID: <CAG27Bk0ddxfVP98dxWiS+XjoGcM2gv1O78L3wBcVXDKNjMjMQg@mail.gmail.com>
Subject: Re: Hypervisor & Virtualization lscpu test fail
From: Sami Kerola <kerolasa@iki.fi>
To: Luis Aranguren <pizzaman@hotmail.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 11, 2013 at 1:44 AM, Luis Aranguren <pizzaman@hotmail.com> wrote:
> Thanks for the reply. I include the output file from mk-input.sh, I have
> to note that there were a three permission denied instances.

Oh, I did not look the code before asking the stuff from /proc/. It
seems the lscpu detects virtualization by looking characteristics of
cpu. See cpuid() from

https://github.com/karelzak/util-linux/blob/master/sys-utils/lscpu.c#L453

Perhaps turning off call to that function is the most sensible thing
to do. Any thoughts?

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 824c8b7..27f2567 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1217,9 +1217,9 @@ print_summary(struct lscpu_desc *desc, struct
lscpu_modifier *mod)
 		else if (!strcmp(desc->virtflag, "vmx"))
 			print_s(_("Virtualization:"), "VT-x");
 	}
-	if (desc->hypervisor)
+	if (desc->hypervisor && mod->system == SYSTEM_LIVE)
 		print_s(_("Hypervisor:"), desc->hypervisor);
-	if (desc->hyper) {
+	if (desc->hyper && mod->system == SYSTEM_LIVE) {
 		print_s(_("Hypervisor vendor:"), hv_vendors[desc->hyper]);
 		print_s(_("Virtualization type:"), _(virt_types[desc->virtype]));
 	}

> Feel free to use it as part of the regression test suite.

Thank you.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
