Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9851D5ACE
	for <util-linux@vger.kernel.org>; Mon,  3 Nov 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177014; cv=none; b=tY3Qwmb55CJN68Y2nLIRBNz48Hzt668L3hI5JNbg1W+IU+qFjDFsyUcEoeByN8m4ZP/b8SUY7+NKRtmpYBBjL3vh62VTI6XPmncvr9UnnPdoGPBblRx5VK7QgHhIzEMjt2ukLg3HMuMF44/TffHO4QhOi4oSpTkkLHNEF0+xzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177014; c=relaxed/simple;
	bh=A5U8xKLA/ePA3swNJsun44PUo625xIkCqyx8jlGxFeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyeUfHnwpy3sW5A7nO8oFP25LTKehQn01wOBqbW0WVOIttCyf/d4FuQMQPIlvIMnMihOJUwZnYs5ZZYc9+A8U4uhamUII6Ckv2kuT3SFRTst+PX5F3DNHtchk16SLHjaUblXNvK76yAC7J/2Fu64p2OT1Zb4yXVvDqjo/eRmh/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHhOwg9M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHhOwg9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762177011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wtmANIcPuI7S6oNHYjmHSh8ZDe282yUZwVq7fxwKW0k=;
	b=dHhOwg9MwEEfHGuBaQys6wXadNIjsH36yJrooJKsqTYG2thNTdrj/gECPTUfqp31oZ3v3B
	AFY8/TBehQe6mdj8abh/yqWxJ8l9WJGFzojFRKp7zFsXN553P0XJbFzLYn0eOZAgT3987E
	6ocI1uiESM7EuL02PAzOdQ05aZpSmRI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-1e8OGYh8Moa0wybv6g0BzQ-1; Mon,
 03 Nov 2025 08:36:48 -0500
X-MC-Unique: 1e8OGYh8Moa0wybv6g0BzQ-1
X-Mimecast-MFC-AGG-ID: 1e8OGYh8Moa0wybv6g0BzQ_1762177007
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9963519560B5;
	Mon,  3 Nov 2025 13:36:47 +0000 (UTC)
Received: from ws.localdomain (unknown [10.45.242.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AF7F1955BE3;
	Mon,  3 Nov 2025 13:36:46 +0000 (UTC)
Date: Mon, 3 Nov 2025 14:36:43 +0100
From: Karel Zak <kzak@redhat.com>
To: Dick Marinus <dick@mrns.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: reflink utils
Message-ID: <4j4s35hqascwnb7hvpg7ony7eia6qabvu3qegwjgi6faisnpm4@y62d6gxpzciu>
References: <176198657938.2807.15997469587039898204@routi.mrns.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176198657938.2807.15997469587039898204@routi.mrns.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


 Hi Dick,

On Sat, Nov 01, 2025 at 09:42:59AM +0100, Dick Marinus wrote:
> I've created some tools to work with reflinks (FICLONERANGE) which I'd
> like to include in the util-linux project.
> 
> Reflinks can be used to share equal blocks between files. Cloning a
> block using reflinks will not copy any data saving I/O and disk wear/
> space.

Yes, we already support "hardlink --reflink" for this purpose.

> First tool is blkdiff which takes two files, a base file and a new file. 
> Then it creates both a delta file and an index, the delta file contains
> the different blocks in new file compared to the base file and an index
> file which contains the block indexes in either the base file or the
> delta file so the new file can be constructed from that.
> 
> This is a bit similar to rdiff from librsync but uses fixed block sizes
> and doesn't require the chunks to be in the same order. FICLONERANGE
> only allows you to clone blocks of the filesystems block size.
> 
> The next tool is blkpatch which uses the base, index and delta file to
> construct new file using reflinks.
> 
> I've also created blkcat which concatenates the blocks from all supplied
> files using reflinks into a single file with the idea to use this as a
> basefile to deduplicate files on a filesystem.
> 
> I think reflinks, or at least FICLONERANGE is linux specific so
> util-linux would be a good fit. Reflinks are currently supported (AFAIK)
> for BtrFS and XFS.
> 
> I'd love to know:
> 
> - can/should I contribute these to util-linux?

The first thing I always ask is if the functionality can be added to
an existing tool. In your case, the idea is so original that I don't
see anything we can integrate it into.

> - are blkdiff, blkpatch and blkcat good names?

The "blk" prefix makes it seem like it's for block devices instead of files.

How about following the ioctl name and using one tool that supports
more commands, like:

  ficlone diff
  ficlone patch
  ficlone cat

The issue is that users might not be familiar with ioctl, so "ficlone"
might not appeal to them. 

Perhaps use "reflink" as a name. Then you will have a generic tool,
and you can add features like "reflink copy" or "reflink status," etc.

> - what's required more? I can image I need to add some man pages etc.

Yes, man pages, bash-completion scripts, and ideally some tests, but
don't waste time on man pages, etc., before the code is ready to
merge.

> I already found the Documentation/howto-contribute.txt which I would
> use to contribute these utilities. GPL-2 is fine with me.

It's best to create a draft pull request on GitHub so we can all play
with it, review it, etc.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

