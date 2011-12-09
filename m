Return-Path: bernhard.voelker@siemens-enterprise.com
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: "dave@gnu.org" <dave@gnu.org>, Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>
Date: Fri, 9 Dec 2011 10:48:06 +0100
Subject: RE: [PATCH] prlimit: return proper type
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0D87014694@MCHP058A.global-ad.net>
References: <1323375559.2562.2.camel@offbook>
In-Reply-To: <1323375559.2562.2.camel@offbook>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

Davidlohr Bueso wrote:

> The add_prlim() function's definition currently returns a bogus structure=
.

> -static struct prlimit *add_prlim(char *ops, struct list_head *lims, size=
_t id)
> +static int add_prlim(char *ops, struct list_head *lims, size_t id)

Why not void and remove that return stmt?
The return code is not used anywhere.

Have a nice day,
Berny=
