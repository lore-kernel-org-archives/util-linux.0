Return-Path: elseifthen@gmx.com
Subject: Re: versioning
To: Karel Zak <kzak@redhat.com>
References: <20170517074741.ltxnoawwvj56gc3m@ws.net.home>
 <591C8A09.6070100@gmail.com> <201705172107.49456.sweet_f_a@gmx.de>
 <20170517210953.dskdxcr3rdmbtvgs@ws.net.home>
 <CAG27Bk17xasjeZQP6YpzUvchZJ5mtG2K4w0dirRybxu98-pAcQ@mail.gmail.com>
 <20170518103640.3dedmk7lat74biev@ws.net.home>
 <24e52021-2e94-68a7-bd8c-51362af1d749@gmx.com>
 <20170518195648.gxhsd4zak57wfcg3@ws.net.home>
 <2d5ad507-f51c-7b1b-3aa3-355609cb609c@gmx.de>
 <dfa49f1d-e310-667a-20d3-897bbff2ea83@gmx.com>
 <20170520193446.bt44te35kji2gmzo@ws.net.home>
Cc: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>,
 util-linux <util-linux@vger.kernel.org>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <b6e7901f-4df8-6842-0475-0290d110f68e@gmx.com>
Date: Mon, 22 May 2017 17:37:28 -0400
MIME-Version: 1.0
In-Reply-To: <20170520193446.bt44te35kji2gmzo@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 05/20/2017 03:34 PM, Karel Zak wrote:
> On Fri, May 19, 2017 at 03:00:14PM -0400, J William Piggott wrote:
>> git-pull(1): By default, tags that point at objects that are downloaded
>> from the remote repository are fetched and stored locally.
>>
>> If a tag is created from the master branch, then (with the default
>> configuration) pulling the master branch will pull the tag as well.
>>
>> I think perhaps Karel changed his bugfix release workflow and started
>> creating them from a working branch. 
> 
> I always use master branch.
> 
> $ git branch --contains  v2.30-rc1
> * master
>

So, I muddied the waters by talking about two different topics.
What I really want to discuss are bugfix releases: v2.xx.x.

The following comment should have been a separate topic. I mentioned it
only because the odd behavior that I experienced with the recent rc
release sparked the thought that the bugfix releases are being created
in a working branch and that could explain why 'git pull' is not
fetching their tags.

>> I say that because the
>> v2.30-ReleaseNotes file never hit my local repo, the master branch,
>> until May 16th. That is why I submitted my patch for it as a simple diff
>> instead of a git format-patch.
> 
> https://github.com/karelzak/util-linux/blob/master/Documentation/releases/v2.30-ReleaseNotes
>                                             ^^^^^^
> 
> as well as on kernel.org:
> 
> https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tag/?h=v2.30-rc1

I wasn't trying to say that this file isn't in 'master', nor that the
stable releases cannot be reached from 'master'; they certainly can be
as they are in the 'master' commit log.

What I was saying is that the release was on May 12. The commit the tag
references hit my repo on May 14, but the v2.30-ReleaseNotes file did
not pull until May 16; May 15 had nothing:

$ find -newermt "-12 day" -printf "%TD %p\n" | sort

 8< ...

05/14/17 ./AUTHORS
05/14/17 ./NEWS
05/14/17 ./aclocal.m4
05/14/17 ./config.h.in
05/14/17 ./configure.ac
05/14/17 ./po/ca.po

 8< ...

05/16/17 ./Documentation/TODO
05/16/17 ./Documentation/releases/v2.30-ReleaseNotes

This seems odd to me, but has all worked out now. The v2.30-rc1 tag
contains the unpatched v2.30-ReleaseNotes without the security warnings,
but I guess that is what v2.30-rc2 is for ;)

Enough of that, the real topic is below.

> 
>> It seems to me that the working branch should be merged into master
>> first, and then create the tag, tarball, etc. from master.  That way
>> pulling master will fetch the release tags. That should be expected
>> behavior.
>>
>> IMO, creating releases from an ephemeral branch, or anything other than
>> master, is asking for headaches.
> 
> Maybe you need 'git clean -xdf' before 'git pull' or so.
>

The bugfix tags 2.xx.x are from another branch and not reachable from
'master', it's not because my local repo is dirty. Here is an example
with a fresh repo:

S git clone https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
 8< ...
$ cd util-linux
$ git branch --contains v2.29.1  
$ git branch --contains v2.29.2
$ git branch --contains v2.28.1
$ git branch --contains v2.27.1
$ git branch --contains v2.26.1
$ git branch --contains v2.25.1
$ git branch --contains v2.24.1
$ git branch --contains v2.23.1
$ git branch --contains v2.22.1
$ git branch --contains v2.21.1
$ git branch --contains v2.20.1
$ git branch --contains v2.19.1
$ git branch --contains v2.17.1
$ git branch --contains v2.16.1
$ git branch --contains v2.15.1
$ git branch --contains v2.14.1
$ git branch --contains v2.13.1

For example this tag was created from a working branch:

$ git show v2.29.1

 8< ...

commit 9ebc8a7a882ddfd93bc3262514791a0dcaadba09
Author: Karel Zak <kzak@redhat.com>
Date:   Fri Jan 20 14:13:08 2017 +0100

    build-sys: release++ (v2.29.1)
    
    Signed-off-by: Karel Zak <kzak@redhat.com>

 8< ...
 ____________________________________________________

The commit, and therefore the tag, is not in 'master' and is not
reachable from master.

Some issues with this model:

* 'git pull upstream master', etcetera, will not fetch the bugfix
     release tags because they are not reachable from 'master'.
     This could be unexpected behavior for someone new to the project.

* A checked-out bugfix release tag has all of the releases in the NEWS
     file. Whereas, 'master' omits the bugfix releases.

* A checked-out bugfix release tag has all of the v*-ReleaseNotes.
     Whereas, 'master' omits all of the bugfix v2.xx.x-ReleaseNotes.

* The previous two make these orphaned tags more complete then 'master' is.

* I don't know this for a fact, but I suspect that due to the tags not
    being reachable from any branch that they might have to store the
    entire file tree? If yes, it means more bandwidth and storage use.

These aren't issues for me personally, I just thought it was something
the project should consider.

My thoughts are that bugfix releases should be committed to 'master' the
same as the stable/rc releases are. Then the tag created from that commit.


>>>> I push to the both repos in the same time
>>>> $ git push; git push github master; git push --tags; git push github --tags
>>
>> I think it would be better to:
>>
>> git push --follow-tags; git push --follow-tags github master
> 
> $ git push --follow-tags; git push --follow-tags github master
> Everything up-to-date
> Everything up-to-date
>

Well, 'git push --tags' already uploaded all of the tags, so at the moment
using --follow-tags isn't very meaningful. It could be in the future
though. Of course, if the bugfix tags continue to be unreachable from
master, then you will have to go back to using 'git push --tags'.


>> This would be a good crosscheck to know that the release tags were
>> created against master and not some other branch.
>>
>> Also, one day you may want to have some private tags and --tags will
>> push everything.  Whereas, --follow-tags will only push tags associated
>> with what is being pushed, that is, the master branch.
> 
> OK.
> 
>     Karel
> 
