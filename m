Return-Path: bensberg@justemail.net
Message-Id: <1460014488.2329099.571528281.0C82477B@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <201604062230.39699.sweet_f_a@gmx.de>
References: <201604061259.21979.sweet_f_a@gmx.de>
 <20160406123711.a6rs7reswn6jzj3l@ws.net.home>
 <201604062230.39699.sweet_f_a@gmx.de>
Subject: Re: question about translations
Date: Thu, 07 Apr 2016 09:34:48 +0200
List-ID: <util-linux.vger.kernel.org>


On Wed, Apr 6, 2016, at 22:30, Ruediger Meier wrote:
> Well, I was wondering if this fuzzy (non-sense) message would be really 
> shown if translators do not fix it before release.

No, to gettext "fuzzy" means "invalid", "don't use".  The PO files
are 'compiled' by msgfmt into .MO files which are used at runtime,
and msgfmt ignores any messages that are marked fuzzy.

> (Because I've felt 
> guilty to add a new message in 9508e297 (after rc1!).

Adding or changing messages will never cause any /wrong/
translations to be shown, so there is no problem.

Benno

-- 
http://www.fastmail.com - Same, same, but different...
