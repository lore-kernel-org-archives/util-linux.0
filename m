Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:54353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756512AbdESTA3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 19 May 2017 15:00:29 -0400
Subject: Re: versioning
To: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>,
        Karel Zak <kzak@redhat.com>
References: <20170517074741.ltxnoawwvj56gc3m@ws.net.home>
 <591C8A09.6070100@gmail.com> <201705172107.49456.sweet_f_a@gmx.de>
 <20170517210953.dskdxcr3rdmbtvgs@ws.net.home>
 <CAG27Bk17xasjeZQP6YpzUvchZJ5mtG2K4w0dirRybxu98-pAcQ@mail.gmail.com>
 <20170518103640.3dedmk7lat74biev@ws.net.home>
 <24e52021-2e94-68a7-bd8c-51362af1d749@gmx.com>
 <20170518195648.gxhsd4zak57wfcg3@ws.net.home>
 <2d5ad507-f51c-7b1b-3aa3-355609cb609c@gmx.de>
From: J William Piggott <elseifthen@gmx.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-ID: <dfa49f1d-e310-667a-20d3-897bbff2ea83@gmx.com>
Date: Fri, 19 May 2017 15:00:14 -0400
MIME-Version: 1.0
In-Reply-To: <2d5ad507-f51c-7b1b-3aa3-355609cb609c@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 05/18/2017 04:55 PM, Rüdiger Meier wrote:
> 
> 
> On 05/18/2017 09:56 PM, Karel Zak wrote:
>> On Thu, May 18, 2017 at 02:08:49PM -0400, J William Piggott wrote:
>>> On 05/18/2017 06:36 AM, Karel Zak wrote:
>>>
>>>   8< ---
>>>
>>>>
>>>> The important thing on rcN is that we have official tarball, so you
>>>>
>>>> can use it independently on git, add to distros etc.
>>>>
>>>
>>>   8< ---
>>>
>>> Karel, I pull from github and haven't seen a new tag since v2.29.
>>> Perhaps I should be pulling from kernel.org, but github should work,
>>> no?
> 
> I think "git pull" does not always give you all the tags. In doubt I
> do explicitly "git fetch --tag remote-name".  Maybe "git pull" only
> pulls tags if remote-name == origin, I still don't got the full logic.

Using 'git pull' against master fetched the tags up through v2.29. Then
it stopped.

git-pull(1): By default, tags that point at objects that are downloaded
from the remote repository are fetched and stored locally.

If a tag is created from the master branch, then (with the default
configuration) pulling the master branch will pull the tag as well.

I think perhaps Karel changed his bugfix release workflow and started
creating them from a working branch. I say that because the
v2.30-ReleaseNotes file never hit my local repo, the master branch,
until May 16th. That is why I submitted my patch for it as a simple diff
instead of a git format-patch.

It seems to me that the working branch should be merged into master
first, and then create the tag, tarball, etc. from master.  That way
pulling master will fetch the release tags. That should be expected
behavior.

IMO, creating releases from an ephemeral branch, or anything other than
master, is asking for headaches.

>> I push to the both repos in the same time
>> $ git push; git push github master; git push --tags; git push github --tags

I think it would be better to:

git push --follow-tags; git push --follow-tags github master

This would be a good crosscheck to know that the release tags were
created against master and not some other branch.

Also, one day you may want to have some private tags and --tags will
push everything.  Whereas, --follow-tags will only push tags associated
with what is being pushed, that is, the master branch.


 8< ---

>>
>>> Isn't the KNOWN BUGS: referring to the v2.13.1 branch as a typo, not
>>> the tag?
>>
>> $ git tag -l | grep v2.13.1 v2.13.1 v2.13.1-REAL
>>
>> v2.13.1-rc1
>>
>> v2.13.1-rc2
>>
>> v2.13.1.1
>>
>> the first line is unwanted tag...  it would be possible to delete it,
>> but I don't think that remove already published tags is a good idea.

I see, but isn't the v2.13.1 branch a 'bug' also, because there are not
any bugfix release branches? Well like you said, it's old and doesn't
matter much now.


> 
> It should not be a problem to delete tags like it's no problem to
> delete branches.  Only rebasing branches or re-creating conflicting
> tags could be annoying or at least confusing.
> 
> 
> cu, Rudi
> 
> 
> 
>>     
>> Karel
>>
> -- To unsubscribe from this list: send the line "unsubscribe
> util-linux" in
> 
> the body of a message to majordomo@vger.kernel.org
> 
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
> 
