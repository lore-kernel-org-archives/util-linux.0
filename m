Return-Path: <SRS0=LZ/s=WQ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786CBC3A589
	for <util-linux@archiver.kernel.org>; Tue, 20 Aug 2019 15:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A3F22CE3
	for <util-linux@archiver.kernel.org>; Tue, 20 Aug 2019 15:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfHTPmM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:42:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59872 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfHTPmL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 20 Aug 2019 11:42:11 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i06Gw-00041O-Pt; Tue, 20 Aug 2019 09:42:10 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i06Gv-0002KY-I9; Tue, 20 Aug 2019 09:42:10 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <3fcfc033d9d115649fee5f9ae05296c29033a7de.1565866421.git.ps@pks.im>
        <20190820125132.iq3w234ump62mnmb@10.255.255.10>
        <20190820130930.GA50493@ncase>
Date:   Tue, 20 Aug 2019 10:41:59 -0500
In-Reply-To: <20190820130930.GA50493@ncase> (Patrick Steinhardt's message of
        "Tue, 20 Aug 2019 15:09:30 +0200")
Message-ID: <87ef1fj12w.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i06Gv-0002KY-I9;;;mid=<87ef1fj12w.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18hWYkj0+GFmDQgyES5znFiwAbhl5uX+RQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] unshare: allow setting up filesystems in the mount namespace
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Aug 20, 2019 at 02:51:32PM +0200, Karel Zak wrote:
>> On Thu, Aug 15, 2019 at 12:54:45PM +0200, Patrick Steinhardt wrote:
>> > In order to execute commands with the least-possible privileges, it may
>> > be desirable to provide them with a trimmed down filesystem view.
>> > unshare naturally provides the ability to create mount namespaces, but
>> > it doesn't yet offer much in preparing these. For now, a combination of
>> > unshare and nsenter is required to prepare culled filesystems views,
>> > which is kind of unwieldy.
>> > 
>> > To remedy that, this implements a new option "--mount-fs". As
>> > parameters, one may specify a source filesystem, the destination where
>> > this filesystem shall be mounted, the type of filesystem as well as a
>> > set of options. unshare will then mount it using libmount right before
>> > performing `chroot`, `chdir` and the subsequent `execve`, which allows
>> > for preparing the `chroot` environment without using nsenter at all.
>> >
>> > The above is useful in several different cases, for example when one
>> > wants to execute the process in a read-only environment or execute it
>> > with a reduced view of the filesystem.
>> 
>> I understand your point of view, but it's a way how unshare(1) will
>> slowly grow from simple one-purpose tool to complex container/namespace
>> setup tool ;-) I do not have any strong opinion about it. Maybe your 
>> --mount-fs is still so basic that we can merge it into unshare(1)
>> 
>> Sounds like we need a discussion about it to gather more opinions :-)
>> (CC to Eric).
>
> Sounds fair to me. The main motivation I have is that I want to
> use unshare(1) as part of runit(8) to spawn supervised processes
> in their own namespaces. And using multiple steps to set up
> namespaces and spawn the executable makes things a lot more error
> prone.

My vision of unshare is a simple command line debugging tool.  It let's
you get at the raw functionality.  It might be useful in scripts but it
doesn't provide a nice environment.  The secondary purpose I see for
unshare is as a small example that shows how easy it is to use all
of the functionality.

At least for me unshare is what I turn to do all of the steps manually,
and keeping it simple and focused is a major benefit to that cause.

>> Note that the latest mount(8) has --namespace option, so you can mount
>> filesystems in the another namespace although the namespace does not
>> contain mount command and necessary libs.
>
> That would require me to set up persistent namespaces first,
> though, while unshare(1) allows me to use transient ones that
> disappear as soon as the executable exits.
>
>> And note that for systemd based distros there is systemd-nspawn which
>> provides many many features (include IPC, hostname, TZ, private users,
>> ...).
>
> Yeah, I know of that one, but as I'm using runit(8) as PID1
> systemd-nspawn(1) is not a viable route, at least as far as I
> know. I'm definitely inspired by that tool, though, and would
> love to have something similar that is completely agnostic of
> what init system is running.
>
>> > +.B # unshare
>> > +.B    --mount-fs=none:/tmp:tmpfs
>> > +.B    --mount-fs=/bin:/tmp/bin:none:bind,ro,X-mount.mkdir
>> > +.B    --mount-fs=/lib:/tmp/lib:none:bind,ro,X-mount.mkdir
>> > +.B    --mount-fs=/usr/lib:/tmp/usr/lib:none:bind,ro,X-mount.mkdir
>> > +.B    --root=/tmp /bin/ls /
>> 
>> The libmount also allows to mount all filesystem according to mount
>> table stored in a file, so I can imagine --fstab option ;-)
>
> I thought about exposing parsing of fstab-style lines from
> libmount. But I'd definitely be happy to implement an "--fstab"
> option instead, that would work perfectly fine for my own usecase
> and probably simplify code by quite a bit.

The tricky part of all of this appears to be permission management.  As
soon as you change your uids and/or exec you are in trouble.  As that
will cause you to loose CAP_SYS_ADMIN (unless you are running a service
as root).

My sense is that it would be easiest to write a little tool that does
what you need to run services.  Possibly as a PAM plugin.  I know
originally that is how the unshare system call was expected to be used,
and unshare fits in well with that model.  The example of a PAM plugin
is that potentially runit and sshd could be convinced to setup the
environment for you when you start them.

In fact I think there might already be a PAM plugin for a private /tmp.

Now maybe util-linux is the place for that tool to live.  But I don't
think the unshare command itself is where we want to put the
functionality.

Eric
