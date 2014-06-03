Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56998 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753105AbaFCTqU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 3 Jun 2014 15:46:20 -0400
Message-Id: <1401824774.18762.124788753.6397C030@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>,
        "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20140603112732.GR9000@x2.net.home>
References: <201406020056.17074.sweet_f_a@gmx.de>
 <20140602094243.GM9000@x2.net.home>
 <201406021233.23463.sweet_f_a@gmx.de>
 <20140603112732.GR9000@x2.net.home>
Subject: Re: build-sys: minor issues
Date: Tue, 03 Jun 2014 21:46:14 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, Jun 3, 2014, at 13:27, Karel Zak wrote:
> On Mon, Jun 02, 2014 at 12:33:23PM +0200, Ruediger Meier wrote:
> > 1. Don't track these po files in git at all. Always generate in
> >    builddir. Put them into dist only.
> 
>  No, I'm sure we want to have .po files in the git, it's part of the package.

Well, I think it's nice to have copies of those files in many repos around the
globe, but it's not really needed.  And thus several GNU packages (coreutils,
grep, tar) have chosen to drop the PO files from their version control.  The
files get fetched from the TP at release time.

> > 2. Don't update them with "make dist". Add new target "make update-po".
> 
>  Well, I use "make distcheck" to generate the final release tarballs
>  and it would be nice to keep it usable :-)

Easy: add another target, "make release", that does an update-po and
then distcheck.  :)

Benno

-- 
http://www.fastmail.fm - Send your email first class

