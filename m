Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:57190 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094AbaETQeY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 12:34:24 -0400
Message-ID: <1400603662.5497.86.camel@oct.suse.cz>
Subject: Re: [PATCH 0/5] lscpu: improve hypervisor detection
From: Stanislav Brabec <sbrabec@suse.cz>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Petr Uzel <petr.uzel@suse.cz>
Date: Tue, 20 May 2014 18:34:22 +0200
In-Reply-To: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ruediger Meierwrote:

> I've splitted the original patch into smaller pieces, removed some
> incompatible output format changes and added some test data.

There was a controversial part of this patch, that causes test failure.

There should be a way how to output result of the virtual machine
detection without breaking test cases (and possibly existing scripts).

Index: util-linux-2.24.1/sys-utils/lscpu.c
===================================================================
--- util-linux-2.24.1.orig/sys-utils/lscpu.c
+++ util-linux-2.24.1/sys-utils/lscpu.c
@@ -1181,6 +1322,7 @@ print_parsable(struct lscpu_desc *desc,
 		}
 		fputs(data && *data ? data : "", stdout);
 	}
+	printf(",HvVendor,VirtType");
 	putchar('\n');
 
 	/*
@@ -1210,7 +1352,9 @@ print_parsable(struct lscpu_desc *desc,
 					     buf, sizeof(buf));
 			fputs(data && *data ? data : "", stdout);
 		}
-		putchar('\n');
+		printf(",%s,%s\n",
+		       hv_vendors[desc->hyper] ? hv_vendors[desc->hyper] : "none",
+		       virt_types[desc->virtype]);
 	}
 }
 

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

