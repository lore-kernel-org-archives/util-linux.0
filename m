Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42253 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755379AbdERT4w (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 18 May 2017 15:56:52 -0400
Date: Thu, 18 May 2017 21:56:48 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: versioning
Message-ID: <20170518195648.gxhsd4zak57wfcg3@ws.net.home>
References: <20170517074741.ltxnoawwvj56gc3m@ws.net.home>
 <591C8A09.6070100@gmail.com>
 <201705172107.49456.sweet_f_a@gmx.de>
 <20170517210953.dskdxcr3rdmbtvgs@ws.net.home>
 <CAG27Bk17xasjeZQP6YpzUvchZJ5mtG2K4w0dirRybxu98-pAcQ@mail.gmail.com>
 <20170518103640.3dedmk7lat74biev@ws.net.home>
 <24e52021-2e94-68a7-bd8c-51362af1d749@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <24e52021-2e94-68a7-bd8c-51362af1d749@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 18, 2017 at 02:08:49PM -0400, J William Piggott wrote:
> On 05/18/2017 06:36 AM, Karel Zak wrote:
> 
>  8< ---
> 
> > 
> > The important thing on rcN is that we have official tarball, so you
> > can use it independently on git, add to distros etc.
> 
>  8< ---
> 
> Karel,
> I pull from github and haven't seen a new tag since v2.29. Perhaps I
> should be pulling from kernel.org, but github should work, no?

I push to the both repos in the same time

$ git push; git push github master; git push --tags; git push github --tags
Everything up-to-date
Everything up-to-date
Everything up-to-date
Everything up-to-date

And I see the tags at https://github.com/karelzak/util-linux/tags

> Also, it looks like Documentation/source-code-management.txt needs to be
> updated. There are no bugfix branches, only tags.

Good point. Updated.

> Isn't the KNOWN BUGS:
> referring to the v2.13.1 branch as a typo, not the tag?

$ git tag -l | grep v2.13.1
v2.13.1
v2.13.1-REAL
v2.13.1-rc1
v2.13.1-rc2
v2.13.1.1

the first line is unwanted tag... it would be possible to delete it, but I
don't think that remove already published tags is a good idea.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
