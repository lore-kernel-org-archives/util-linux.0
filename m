Return-Path: bernhard.voelker@siemens-enterprise.com
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Karel Zak <kzak@redhat.com>, "corentin.labbe" <corentin.labbe@geomatys.fr>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Wed, 20 Jul 2011 15:33:04 +0200
Subject: RE: [PATCH] dmesg.c: print human readable timestamp
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A08FE26DD8A@MCHP058A.global-ad.net>
References: <4DD6593D.2090202@geomatys.fr>
 <20110629145957.GM6418@nb.net.home> <4E2449B6.1070105@geomatys.fr>
 <20110720124826.GA22568@nb.net.home>
In-Reply-To: <20110720124826.GA22568@nb.net.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

> The latest dmesg(1) changes:
>
>  * -T, --ctime       : print human readable timestamps

shouln'd -T and -t or -r be mutually exclusive?

Currently, -T wins over -t, and -r wins over -T.

Have a nice day,
Berny=
