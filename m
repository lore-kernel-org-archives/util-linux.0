Return-Path: ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>, util-linux@vger.kernel.org,
        Mikhail Gusarov <dottedmag@dottedmag.net>
References: <1419798218-3174-1-git-send-email-lkundrak@v3.sk>
	<1419798218-3174-2-git-send-email-lkundrak@v3.sk>
	<20150106130343.GG18528@x2.net.home>
	<87y4pfomui.fsf@x220.int.ebiederm.org>
	<20150106172134.GJ18528@x2.net.home>
Date: Tue, 06 Jan 2015 11:44:53 -0600
In-Reply-To: <20150106172134.GJ18528@x2.net.home> (Karel Zak's message of
	"Tue, 6 Jan 2015 18:21:34 +0100")
Message-ID: <87d26rolbe.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 2/2] unshare: allow persisting namespaces
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> On Tue, Jan 06, 2015 at 11:11:49AM -0600, Eric W. Biederman wrote:
>> No.  An empty pid namespace is valid.   An empty pid namespace is one
>> in which an init process has not entered the pid namespace, or one in
>
> but if I create a PID namespace (unshare/clone) then then I'm the init
> process.... how I can create empty PID namespace (from userspace)?

Unshare creates an empty PID namespace.  Your first child when you fork
becomes the init process.  You can not change your current pid namespace
only the pid namespace for your children.

>> which the init process has exited (and thus no more processes are
>> allowed).
>
> yes, this makes sense
>
>> So an empty pid namespace is a little weird but valid.
>> 
>> The implementation details of the patch completely baffle me.  I can't
>> see a reason for things being implemented with clone for example.
>
> Yes, this part of the patch is strange, but I like the basic idea
> of the patch -- so make it possible to create an empty namespace and 
> then later enter by nsenter.

The idea of making a new namespace and making it possible to enter it
later with nsenter seems reasonable. 

But really that should be just a matter of adding the C equivalent of
"mount --bind /proc/self/ns/$TYPE $FILENAME" which should be a very
trivial addition to unshare.

Eric
