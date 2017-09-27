Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] losetup: Add support for logical block size
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <ea2d1f7c-ca7b-331f-06c6-54e122a74382@suse.cz>
 <20170927124130.774g7kysxbdlc2wv@ws.net.home>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <e5377128-622b-5c01-bfa8-2cbbacd513f2@suse.cz>
Date: Wed, 27 Sep 2017 14:48:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170927124130.774g7kysxbdlc2wv@ws.net.home>
Content-Type: text/plain; charset=iso-8859-2
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> Merged (with fixed get() function).
> 
> I'm not sure about the "BLOCKSIZE" column name. For lsblk we use
> "LOG-SEC" (and "PHY-SEC"), it seems more explicit and shorter. What
> about to use the same column name for losetup too? From my point of
> view "BLOCKSIZE" is too vague it would be nice to minimize differences
> in terminology used by the tools (losetup and lsblk).

It makes sense.

> Maybe we can also rename "--logical-blocksize" to "--log-sector".
> 
Maybe. But --log-* can associate logging. What about --logical-size or
--sector-size or only --sectors?

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
