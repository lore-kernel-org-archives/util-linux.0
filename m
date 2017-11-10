Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.headstrong.de ([81.7.4.112]:40824 "EHLO mail.headstrong.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbdKJOWS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 10 Nov 2017 09:22:18 -0500
Subject: Re: Bug: for mount namespaces inside a chroot, unshare works but
 nsenter doesn't
To: Karel Zak <kzak@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: util-linux@vger.kernel.org
References: <7b168fc6-957c-3c98-d7f2-673842ee550c@pwned.gg>
 <20171103133348.p4coyse7eoibcpsn@ws.net.home> <877euzaws1.fsf@xmission.com>
 <20171110131458.7xlnbf7ayvtk7r2r@ws.net.home>
From: Ximin Luo <infinity0@pwned.gg>
Message-ID: <a72a1d51-fd15-761b-95a3-a99bd6fca524@pwned.gg>
Date: Fri, 10 Nov 2017 14:22:00 +0000
MIME-Version: 1.0
In-Reply-To: <20171110131458.7xlnbf7ayvtk7r2r@ws.net.home>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak:
> [..]
> 
>> My personal recommendation is not to use chroot with persistent mount
>> namespaces.  That just seems to keep unnecessary mounts around.  Those
>> extra mounts will almost certainly be a problem later when you discover
>> you want to unmount one of those mounted filesystems you don't care
>> about but are chrooting over.
>>
>> I think it would be quite reasonable to have an additional option to
>> open things in the new mount namespace, just before exec.  I just don't
>> see how useful it would be.
> 
> It would be solution for this use-case, but it will increase
> complexity and I'm not sure this use-case is important enough.
> 
> Especially if the all you need is to use chroot command before nsenter.
> I don't think nsenter has to be all-in-one command. It's very basic
> tool.
> 

My nsenter code may be run inside or outside a chroot, I have no control over that in the general case - users decide whether they want to run it inside a chroot or not.

The issue with using the chroot(1) command, is that you must give it the path to the chroot *from outside the chroot*. I don't know of a clean way to figure this out from my code, that starts life running from inside the chroot, and just wants to unshare part of the tree that it sees there.

An option to open root/wd in the new ns, sounds like it would allow me (and others) to write code that is chroot-independent. I'd very much appreciate that.

X

-- 
GPG: ed25519/56034877E1F87C35
GPG: rsa4096/1318EFAC5FBBDBCE
https://github.com/infinity0/pubkeys.git
