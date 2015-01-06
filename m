Return-Path: ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>, util-linux@vger.kernel.org,
        Mikhail Gusarov <dottedmag@dottedmag.net>
References: <1419798218-3174-1-git-send-email-lkundrak@v3.sk>
	<1419798218-3174-2-git-send-email-lkundrak@v3.sk>
	<20150106130343.GG18528@x2.net.home>
Date: Tue, 06 Jan 2015 11:11:49 -0600
In-Reply-To: <20150106130343.GG18528@x2.net.home> (Karel Zak's message of
	"Tue, 6 Jan 2015 14:03:43 +0100")
Message-ID: <87y4pfomui.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 2/2] unshare: allow persisting namespaces
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> On Sun, Dec 28, 2014 at 09:23:38PM +0100, Lubomir Rintel wrote:
>> Bind mount the namespace file to a given location after creating it if
>> requested (analogously to what "ip netns" and other tools do). This makes
>> it possible for a namespace to survive with no processes running while
>> processes can enter it with nsenter(1):
>> 
>>   # unshare --uts=utsns hostname behemoth
>>   # nsenter --uts=utsns hostname
>>   behemoth
>
> Nice, especially when we already supports the same concept in nsenter.
>
> But I guess that "empty namespace" (without any running process) is
> impossible for PID namespaces, right? It would be nice to add a note
> about it to the man page.

No.  An empty pid namespace is valid.   An empty pid namespace is one
in which an init process has not entered the pid namespace, or one in
which the init process has exited (and thus no more processes are
allowed).

So an empty pid namespace is a little weird but valid.

The implementation details of the patch completely baffle me.  I can't
see a reason for things being implemented with clone for example.

Eric
