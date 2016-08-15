Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35856 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbcHOK0q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 15 Aug 2016 06:26:46 -0400
Received: by mail-wm0-f48.google.com with SMTP id q128so82490108wma.1
        for <util-linux@vger.kernel.org>; Mon, 15 Aug 2016 03:26:45 -0700 (PDT)
Date: Mon, 15 Aug 2016 12:26:42 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: sbrabec@suse.cz, kzak@redhat.com, util-linux@vger.kernel.org
Subject: Re: UDF label change since commit 2f2730bc77c9
Message-ID: <20160815102642.GI30047@pali>
References: <20160810123859.GA31140@quack2.suse.cz>
 <20160810125349.GC30047@pali>
 <20160810133902.GC1530@quack2.suse.cz>
 <20160810142306.GD30047@pali>
 <20160815094337.GC7371@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160815094337.GC7371@quack2.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 15 August 2016 11:43:37 Jan Kara wrote:
> On Wed 10-08-16 16:23:06, Pali Rohár wrote:
> > On Wednesday 10 August 2016 15:39:02 Jan Kara wrote:
> > > Hi,
> > > 
> > > On Wed 10-08-16 14:53:49, Pali Rohár wrote:
> > > > On Wednesday 10 August 2016 14:38:59 Jan Kara wrote:
> > > > > we have noticed that since commit 2f2730bc77c9 "libblkid: udf: Fix reading
> > > > > LABEL, add support for UUID and other udf identifiers" some volumes have
> > > > > changed labels which are reported by blkid. See [1] for an example.
> > > > 
> > > > "You are not authorized to access bug #983165."
> > > 
> > > Ah, sorry. I forgot the bug is reported against SLES and so is not
> > > publically visible. Anyway, the initial comment which is interesting is:
> > > 
> > > I have a shared paritition with an UDF filesystem. In Win7 64bit its label
> > > is 'ssd120_docs'. In SLES12SP1 its label is 'ssd120_dokumente'. In
> > > Tumbleweed (and most likely also SP2 Beta) its label is 'ssd120_dosemut'
> > > (or similar garbage).
> > > 
> > > I think there should be some consistency in /dev/disk/by-label/*.
> > > ---
> > > 
> > > As an explanation, SLES12SP1 uses util-linux 2.25 (i.e., before your patch),
> > > Tumbleweed is the rolling distro with the latest & greatest version.
> > >  
> > > > > This is
> > > > > because that commit changed what is used for the label - previously we have
> > > > > used 'ident' in the Primary Volume Descriptor, and after that commit we use
> > > > > Logical Volume ID.
> > > > 
> > > > Yes, thats true.
> > > > 
> > > > > I think it would be better to keep consistency with older util-linux
> > > > > releases (e.g. valid /etc/fstab that uses labels may be broken by this
> > > > > change) but I'm not sure whether there is a point once the new behavior
> > > > > has been released in the util-linux release. But still I wanted to raise
> > > > > this since I'm not sure how much util-linux cares about these changes and
> > > > > also so that people are aware of the change...
> > > > > 
> > > > > 								Honza
> > > > > 
> > > > > [1] https://bugzilla.suse.com/show_bug.cgi?id=983165
> > > > > 
> > > > 
> > > > Reason why I proposed that change is because all other software use
> > > > Logical Volume Identifier as label. Just linux blkid used something
> > > > other.
> > > > 
> > > > Basically Linux was incompatible with whole world and I think this was a
> > > > bug. Also UDF specification say something that LVI is displayed to user.
> > > > IIRC also Grub2 uses LVI as label identification.
> > > > 
> > > > So I do not agree with reverting back old behaviour which is
> > > > incompatible with everything except old util-linux versions...
> > > 
> > > Well, this somewhat does not match the description in the bug. Apparently
> > > Win7 uses yet another identifier in the UDF filesystem...
> > 
> > Not good :-( Anyway, are you able to produce/create UDF disk image/dump
> > which show different label under Win7 and new util-linux? With that we
> > can inspect which field is Win7 using and could test also other systems
> > (like some BSD or Grub2) what see...
> > 
> > Maybe there could be different behaviour for CD, DVD, HDD or
> > multisession CD/DVD...
> 
> The reporter has UDF filesystem created on HDD AFAIU. I've asked him to run
> udf_test program on the fs image. From its output we should be able to see
> various identifiers of the filesystem and thus see whan Win7 uses.

Ok, that should help us to detect how Win7 get label...

Anyway, for such output is good tool udfdump from UDFClient project [1].
It has better license so it can be found in some linux distributions.

[1] - http://www.13thmonkey.org/udfclient/

-- 
Pali Rohár
pali.rohar@gmail.com
