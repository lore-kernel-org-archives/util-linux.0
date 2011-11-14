Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6883 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863Ab1KNMpb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Nov 2011 07:45:31 -0500
Date: Mon, 14 Nov 2011 13:45:28 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>, Harald Hoyer <harald@redhat.com>
Subject: Re: [pull] third sys-utils patch set
Message-ID: <20111114124528.GA20881@nb.net.home>
References: <CAG27Bk1acCRkXM=6wf5BRZ_Q6niOheappANqBKHiObZv86GL2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1acCRkXM=6wf5BRZ_Q6niOheappANqBKHiObZv86GL2g@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 02, 2011 at 08:28:43PM +0100, Sami Kerola wrote:
> The switch_root did not use translations. I wonder was that
> intentional, and it should not have them? If so the patch has to be
> knocked out.

 It was probably intentional (I don't remember:-) to ignore NLS in
 switch_root(8), but I think that all utils should be able follow
 locales setting if you ask for --help or --version. I don't see a
 technical reason to disable NLS in switch_root(8).

> The ldattach usage output 'Known ... names' output tables are now
> wider and shorter. IMHO that is better, since the usage is a lot
> longer than it used to be. My only question is that should the output
> tables be more smart,  and use tt_print_table() combined with terminal
> width detection to make table as wide as possible?

 No, please, don't use tt in usage(), it's horrible overkill.

> are available in the git repository at:
>   https://github.com/kerolasa/lelux-utiliteetit sys-utils-3rd

 Merged. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
