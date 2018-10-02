Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeJBQSn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 2 Oct 2018 12:18:43 -0400
Date: Tue, 2 Oct 2018 11:36:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: adilger@dilger.ca,
        Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        util-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        andy.shevchenko@gmail.com, aeb@debian.org, andreas.bombe@gmail.com
Subject: Re: Future of dosfstools project (FAT)
Message-ID: <20181002093619.nrmibtzouwraoyob@ws.net.home>
References: <20180929084038.an6pfhnsd6tblejl@pali>
 <404F3F76-402D-4E29-9957-429CB7D7ECFC@dilger.ca>
 <CAFLxGvxfegQFh0kvk81VLhLh0AkgvpT=hWMDCJz5FmgoTUNRqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFLxGvxfegQFh0kvk81VLhLh0AkgvpT=hWMDCJz5FmgoTUNRqA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 01, 2018 at 10:13:41PM +0200, Richard Weinberger wrote:
> On Mon, Oct 1, 2018 at 10:01 PM Andreas Dilger <adilger@dilger.ca> wrote:
> > If the current dosfstools maintainer is non-responsive, you could always
> > fork the project in GitHub, land the critical patches into your branch,
> >  and make a release on your own.  If the maintainer surfaces again, then
> > they can pull in your patches.  If not, then you are the new maintainer.
> 
> I also recommend talking to package maintainers of major distros.
> Maybe one of them forked the project already and did what you plan to do.
> 
> In any case, let's try to avoid a drama like util-linux-ng was.

Drama? :-) We had confirmed support from all mainstream distros before
the fork and rename. It was really not ad hoc solution. The project
has been renamed back to util-linux after confirmation from the
original maintainer.

Sometimes fork open source project is a good thing. The another
example is mutt -> mutt-kz -> neomutt ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
