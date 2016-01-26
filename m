Return-Path: srn@prgmr.com
Subject: Re: [PATCH] mkswap: Add warnings for insecure device
 permissions/owners
To: Karel Zak <kzak@redhat.com>
References: <1453228626-18667-1-git-send-email-wayneroth42@gmail.com>
 <20160120103042.clphjleuiesjrl52@ws.net.home> <56A1596C.3060507@prgmr.com>
 <56A25241.8050000@imap.cc> <56A27F92.6020309@prgmr.com>
 <CAG27Bk1xN6RccvCKwurdftkHkvS86Mi5VnA-8UiP7Y0peuh02A@mail.gmail.com>
 <20160123162241.pwvqxyfm4qv2apgo@ws.net.home>
 <CAG27Bk26z9GmKnMyE-dffa13F1nRKPMPvdWzpASpJo8ONF_=YQ@mail.gmail.com>
 <20160126104204.sls4bbcxocoscbcc@ws.net.home>
Cc: kerolasa@gmail.com, Tilman Schmidt <tilman@imap.cc>,
        "Wayne R. Roth" <wayneroth42@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
From: Sarah Newman <srn@prgmr.com>
Message-ID: <56A79EB3.8040002@prgmr.com>
Date: Tue, 26 Jan 2016 08:28:35 -0800
MIME-Version: 1.0
In-Reply-To: <20160126104204.sls4bbcxocoscbcc@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

On 01/26/2016 02:42 AM, Karel Zak wrote:
> On Sun, Jan 24, 2016 at 11:09:47AM +0000, Sami Kerola wrote:
>> On 23 January 2016 at 16:22, Karel Zak <kzak@redhat.com> wrote:
>>> On Fri, Jan 22, 2016 at 10:03:47PM +0000, Sami Kerola wrote:
>>>> Alternatively one could make swapon to get rid of all permission bits
>>>> and set ownership to UID 0 by default when ever it activates a
>>>> swapfile. How about that.
>>>
>>> Not sure if want to change any permissions on the fly, it would be
>>> better to reject files (by swapon) with insecure permissions and
>>> require something like --force for crazy users who wants to ignore
>>> this problem.
>>
>> Why not completely optional?
>>
>> $ swapon --path-permissions [ignore|complain|stop|fix]
> 
> I don't think we want to merge another functionality to swapon. The
> warnings are enough. For the rest we have ch{own,mod}. 
> 
> Let's Keep It Simple and Stupid. We all love kisses, right? :-)

Hi Karel,

Your original suggestion for swapon to require '--force' for insecure permissions seems like the most sane thing to do - it protects the user without
adding a lot of knobs. Presumably there would need to a "force" option for fstab too.

But implementing that without advance notice could lead to broken systems. Maybe it would make sense to add the --force option now and change the
warning to indicate that in future versions of swapon, insecure permissions used without --force will be rejected. Then in a couple of years actually
implement that change.

If you agree this is sane behavior appropriate for upstream, I'll get you a patch for swapon.

--Sarah
