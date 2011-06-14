Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110614112919.GE14293@nb.net.home>
References: <1307387239-9022-1-git-send-email-kerolasa@iki.fi>
	<1307387239-9022-7-git-send-email-kerolasa@iki.fi>
	<20110614112919.GE14293@nb.net.home>
Date: Tue, 14 Jun 2011 22:00:56 +0200
Message-ID: <BANLkTik2HR3BCHFta13hg_QK6nXEZm19Pw@mail.gmail.com>
Subject: Re: [PATCH 6/6] sfdisk: fix for data type mismatches
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 14, 2011 at 13:29, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Jun 06, 2011 at 09:07:19PM +0200, Sami Kerola wrote:
>> + =A0 =A0 if ((unsigned long) pno+4 >=3D ARRAY_SIZE(z->partitions)) {
>
> =A0Why 'unsigned long'? I guess that ARRAY_SIZE returns size_t. Maybe it
> =A0would be better to use size_t for partno numbers rather than add the
> =A0cast.

Yes are right, that was silly. I reviewed the patch and changed data
types to size_t. The fix is pushed with force to my git.

p.s. The style in the file is really horrible. How about doing the
following, which will unify the style within the file without changing
everything.

indent -linux -i4 -psl -brf sfdisk.c

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
