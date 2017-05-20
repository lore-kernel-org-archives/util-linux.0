Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756535AbdETTeu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 20 May 2017 15:34:50 -0400
Date: Sat, 20 May 2017 21:34:46 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: versioning
Message-ID: <20170520193446.bt44te35kji2gmzo@ws.net.home>
References: <20170517074741.ltxnoawwvj56gc3m@ws.net.home>
 <591C8A09.6070100@gmail.com>
 <201705172107.49456.sweet_f_a@gmx.de>
 <20170517210953.dskdxcr3rdmbtvgs@ws.net.home>
 <CAG27Bk17xasjeZQP6YpzUvchZJ5mtG2K4w0dirRybxu98-pAcQ@mail.gmail.com>
 <20170518103640.3dedmk7lat74biev@ws.net.home>
 <24e52021-2e94-68a7-bd8c-51362af1d749@gmx.com>
 <20170518195648.gxhsd4zak57wfcg3@ws.net.home>
 <2d5ad507-f51c-7b1b-3aa3-355609cb609c@gmx.de>
 <dfa49f1d-e310-667a-20d3-897bbff2ea83@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dfa49f1d-e310-667a-20d3-897bbff2ea83@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 19, 2017 at 03:00:14PM -0400, J William Piggott wrote:
> > 
> > I think "git pull" does not always give you all the tags. In doubt I
> > do explicitly "git fetch --tag remote-name".  Maybe "git pull" only
> > pulls tags if remote-name == origin, I still don't got the full logic.
> 
> Using 'git pull' against master fetched the tags up through v2.29. Then
> it stopped.
> 
> git-pull(1): By default, tags that point at objects that are downloaded
> from the remote repository are fetched and stored locally.
> 
> If a tag is created from the master branch, then (with the default
> configuration) pulling the master branch will pull the tag as well.
> 
> I think perhaps Karel changed his bugfix release workflow and started
> creating them from a working branch. 

I always use master branch.

$ git branch --contains  v2.30-rc1
* master

> I say that because the
> v2.30-ReleaseNotes file never hit my local repo, the master branch,
> until May 16th. That is why I submitted my patch for it as a simple diff
> instead of a git format-patch.

https://github.com/karelzak/util-linux/blob/master/Documentation/releases/v2.30-ReleaseNotes
                                            ^^^^^^

as well as on kernel.org:

https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tag/?h=v2.30-rc1

> It seems to me that the working branch should be merged into master
> first, and then create the tag, tarball, etc. from master.  That way
> pulling master will fetch the release tags. That should be expected
> behavior.
> 
> IMO, creating releases from an ephemeral branch, or anything other than
> master, is asking for headaches.

Maybe you need 'git clean -xdf' before 'git pull' or so.

> >> I push to the both repos in the same time
> >> $ git push; git push github master; git push --tags; git push github --tags
> 
> I think it would be better to:
> 
> git push --follow-tags; git push --follow-tags github master

$ git push --follow-tags; git push --follow-tags github master
Everything up-to-date
Everything up-to-date

> This would be a good crosscheck to know that the release tags were
> created against master and not some other branch.
> 
> Also, one day you may want to have some private tags and --tags will
> push everything.  Whereas, --follow-tags will only push tags associated
> with what is being pushed, that is, the master branch.

OK.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
