Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:59405 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751101AbdJBL3k (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 2 Oct 2017 07:29:40 -0400
Subject: Re: [PATCH] losetup: Add support for logical block size
From: Stanislav Brabec <sbrabec@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <ea2d1f7c-ca7b-331f-06c6-54e122a74382@suse.cz>
 <20170927124130.774g7kysxbdlc2wv@ws.net.home>
 <e5377128-622b-5c01-bfa8-2cbbacd513f2@suse.cz>
 <20171002100302.n7cckjml5vj72cyt@ws.net.home>
 <80fbf77a-f21e-ee15-ca2b-ba6000b3a79d@suse.cz>
Message-ID: <f132a54b-d1ac-f0d8-8994-bb17304c0595@suse.cz>
Date: Mon, 2 Oct 2017 13:29:39 +0200
MIME-Version: 1.0
In-Reply-To: <80fbf77a-f21e-ee15-ca2b-ba6000b3a79d@suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Stanislav Brabec wrote:
> Then maybe change "-b" command line option to something more appropriate.
> 
Looking that fdisk has the same:
 -b, --sector-size <size>      physical and logical sector size

So maybe "-b" is OK here as well.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
