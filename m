Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.headstrong.de ([81.7.4.112]:60638 "EHLO mail.headstrong.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbdKXNKH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Nov 2017 08:10:07 -0500
Subject: Re: Bug: for mount namespaces inside a chroot, unshare works but
 nsenter doesn't
From: Ximin Luo <infinity0@pwned.gg>
To: Karel Zak <kzak@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: util-linux@vger.kernel.org
References: <7b168fc6-957c-3c98-d7f2-673842ee550c@pwned.gg>
 <20171103133348.p4coyse7eoibcpsn@ws.net.home> <877euzaws1.fsf@xmission.com>
 <20171110131458.7xlnbf7ayvtk7r2r@ws.net.home>
 <a72a1d51-fd15-761b-95a3-a99bd6fca524@pwned.gg>
Message-ID: <4770c632-0af8-332a-f7aa-d1cdec8e204d@pwned.gg>
Date: Fri, 24 Nov 2017 13:09:00 +0000
MIME-Version: 1.0
In-Reply-To: <a72a1d51-fd15-761b-95a3-a99bd6fca524@pwned.gg>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ximin Luo:
> Karel Zak:
>> [..]
>>
>>> My personal recommendation is not to use chroot with persistent mount
>>> namespaces.  That just seems to keep unnecessary mounts around.  Those
>>> extra mounts will almost certainly be a problem later when you discover
>>> you want to unmount one of those mounted filesystems you don't care
>>> about but are chrooting over.
>>>
>>> I think it would be quite reasonable to have an additional option to
>>> open things in the new mount namespace, just before exec.  I just don't
>>> see how useful it would be.
>>
>> It would be solution for this use-case, but it will increase
>> complexity and I'm not sure this use-case is important enough.
>>
>> Especially if the all you need is to use chroot command before nsenter.
>> I don't think nsenter has to be all-in-one command. It's very basic
>> tool.
>>
> 
> My nsenter code may be run inside or outside a chroot, I have no control over that in the general case - users decide whether they want to run it inside a chroot or not.
> 
> The issue with using the chroot(1) command, is that you must give it the path to the chroot *from outside the chroot*. I don't know of a clean way to figure this out from my code, that starts life running from inside the chroot, and just wants to unshare part of the tree that it sees there.
> 
> An option to open root/wd in the new ns, sounds like it would allow me (and others) to write code that is chroot-independent. I'd very much appreciate that.
> 

I tried Karel's patch from earlier and it seems that it does not work as I need it to - with the patch, it is still required to pass the path-to-the-chroot, from the parent mount namespace's "real" root.

I guess the problem stems from the fact that the unshare process's root, is a child-namespace-specific copy of the root from the parent namespace. When the process exists the handle to this root is lost, and nsenter does not have enough information to be able to pick it up again.

And opening the parent namespace's root (inside the chroot), if I understood correctly, does not correspond to a valid file descriptor inside the child namespace, and that's why this bug exists.

Perhaps the solution then, is to offer a way for unshare(1) to save a handle to the root inside the child-namespace, and then nsenter(1) can later be pointed to this root? i.e.

# all commands run inside the chroot
$ unshare --mount=ns-mnt --root=./root true
#                        ^^^^^^^^^^^^^
# this would effectively save (chroot)/proc/self/root to ./root so it's available after the process exits

$ nsenter --mount=ns-mnt --root=./root true
#                        ^^^^^^^^^^^^^
# nsenter can then chroot to this as normal

(The wd is less important to me but I suppose a similar thing could be done with that too.)

I am not sure if the first step is possible in the current kernel however. But it seems to me that it *ought* to be possible, to make chroots and persistent-mount-namespaces play nicely together.

X

-- 
GPG: ed25519/56034877E1F87C35
GPG: rsa4096/1318EFAC5FBBDBCE
https://github.com/infinity0/pubkeys.git
