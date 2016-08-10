Return-Path: pali.rohar@gmail.com
Date: Wed, 10 Aug 2016 14:53:49 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: sbrabec@suse.cz, kzak@redhat.com, util-linux@vger.kernel.org
Subject: Re: UDF label change since commit 2f2730bc77c9
Message-ID: <20160810125349.GC30047@pali>
References: <20160810123859.GA31140@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160810123859.GA31140@quack2.suse.cz>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 10 August 2016 14:38:59 Jan Kara wrote:
> Hi,

Hi!

> we have noticed that since commit 2f2730bc77c9 "libblkid: udf: Fix reading
> LABEL, add support for UUID and other udf identifiers" some volumes have
> changed labels which are reported by blkid. See [1] for an example.

"You are not authorized to access bug #983165."

> This is
> because that commit changed what is used for the label - previously we have
> used 'ident' in the Primary Volume Descriptor, and after that commit we use
> Logical Volume ID.

Yes, thats true.

> I think it would be better to keep consistency with older util-linux
> releases (e.g. valid /etc/fstab that uses labels may be broken by this
> change) but I'm not sure whether there is a point once the new behavior
> has been released in the util-linux release. But still I wanted to raise
> this since I'm not sure how much util-linux cares about these changes and
> also so that people are aware of the change...
> 
> 								Honza
> 
> [1] https://bugzilla.suse.com/show_bug.cgi?id=983165
> 

Reason why I proposed that change is because all other software use
Logical Volume Identifier as label. Just linux blkid used something
other.

Basically Linux was incompatible with whole world and I think this was a
bug. Also UDF specification say something that LVI is displayed to user.
IIRC also Grub2 uses LVI as label identification.

So I do not agree with reverting back old behaviour which is
incompatible with everything except old util-linux versions...

-- 
Pali Rohár
pali.rohar@gmail.com
