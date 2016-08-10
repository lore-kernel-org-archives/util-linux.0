Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46418 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbcHJSef (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Aug 2016 14:34:35 -0400
Date: Wed, 10 Aug 2016 15:49:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Jan Kara <jack@suse.cz>, sbrabec@suse.cz, util-linux@vger.kernel.org
Subject: Re: UDF label change since commit 2f2730bc77c9
Message-ID: <20160810134903.ieypeqnq36o3fpja@ws.net.home>
References: <20160810123859.GA31140@quack2.suse.cz>
 <20160810125349.GC30047@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160810125349.GC30047@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 10, 2016 at 02:53:49PM +0200, Pali Rohár wrote:
> On Wednesday 10 August 2016 14:38:59 Jan Kara wrote:
> > Hi,
> 
> Hi!
> 
> > we have noticed that since commit 2f2730bc77c9 "libblkid: udf: Fix reading
> > LABEL, add support for UUID and other udf identifiers" some volumes have
> > changed labels which are reported by blkid. See [1] for an example.
> 
> "You are not authorized to access bug #983165."
> 
> > This is
> > because that commit changed what is used for the label - previously we have
> > used 'ident' in the Primary Volume Descriptor, and after that commit we use
> > Logical Volume ID.
> 
> Yes, thats true.
> 
> > I think it would be better to keep consistency with older util-linux
> > releases (e.g. valid /etc/fstab that uses labels may be broken by this
> > change) but I'm not sure whether there is a point once the new behavior
> > has been released in the util-linux release. But still I wanted to raise
> > this since I'm not sure how much util-linux cares about these changes and
> > also so that people are aware of the change...
> > 
> > 								Honza
> > 
> > [1] https://bugzilla.suse.com/show_bug.cgi?id=983165
> > 
> 
> Reason why I proposed that change is because all other software use
> Logical Volume Identifier as label. Just linux blkid used something
> other.
> 
> Basically Linux was incompatible with whole world and I think this was a
> bug. Also UDF specification say something that LVI is displayed to user.
> IIRC also Grub2 uses LVI as label identification.
> 
> So I do not agree with reverting back old behaviour which is
> incompatible with everything except old util-linux versions...

I don't plan to revert it after 2 years and change it again. 

We had two possible solutions, but none is perfect. The selected
solution allows us to be more compatible with another systems, but
with a small regression that is very probably invisible for standard
CD users.  (This is first report after two years.)

See the original discussion about it:
http://marc.info/?l=util-linux-ng&m=141812346909875&w=2

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
