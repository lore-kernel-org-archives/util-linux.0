Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34598 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148AbbAFRWB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 Jan 2015 12:22:01 -0500
Date: Tue, 6 Jan 2015 18:21:34 +0100
From: Karel Zak <kzak@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>, util-linux@vger.kernel.org,
        Mikhail Gusarov <dottedmag@dottedmag.net>
Subject: Re: [PATCH 2/2] unshare: allow persisting namespaces
Message-ID: <20150106172134.GJ18528@x2.net.home>
References: <1419798218-3174-1-git-send-email-lkundrak@v3.sk>
 <1419798218-3174-2-git-send-email-lkundrak@v3.sk>
 <20150106130343.GG18528@x2.net.home>
 <87y4pfomui.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y4pfomui.fsf@x220.int.ebiederm.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 06, 2015 at 11:11:49AM -0600, Eric W. Biederman wrote:
> No.  An empty pid namespace is valid.   An empty pid namespace is one
> in which an init process has not entered the pid namespace, or one in

but if I create a PID namespace (unshare/clone) then then I'm the init
process.... how I can create empty PID namespace (from userspace)?

> which the init process has exited (and thus no more processes are
> allowed).

yes, this makes sense

> So an empty pid namespace is a little weird but valid.
> 
> The implementation details of the patch completely baffle me.  I can't
> see a reason for things being implemented with clone for example.

Yes, this part of the patch is strange, but I like the basic idea
of the patch -- so make it possible to create an empty namespace and 
then later enter by nsenter.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
