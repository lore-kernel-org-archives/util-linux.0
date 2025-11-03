Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7B148850
	for <util-linux@vger.kernel.org>; Mon,  3 Nov 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178119; cv=none; b=LJNUxoT6AZc4/Js7/z+CjIGuN/1/5V+jXI2ndYC1uiWnT4lZTMnPViXnDQeeaoutxY+QnxfLp+JKNmrGYDLYryW/QOS8oae+h8anNURpG9rPNoIJSLjpCMNer4SwfKOfa5t7uJPZ4TcTm035Y+v/F8SmG31FcxFtCFpm8Bhq6ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178119; c=relaxed/simple;
	bh=p/iQv2tH+ZjXDs3u+4VBL52lf2OFFcXxlPSmTembiwI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JRThPIBGb5INGC0gs9nsDqSYNZbltRxsWdW1tKy6I97CaiEDM+cMdozcp2omjy2ufek4TUMVqMWS9SrN5BD/rtZM9PHtwpZWg9JTAJDGbnNdWxkqbXtZV63ZJrNmpISBWvymDTjTaLwKm1w4FDcSvj9Y37qhCVaxJmWnf07MYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpcYpiAE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpcYpiAE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762178116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXLC/ZJ+mtMpg8Jg3sAU/sdjEQj2KNiyoax8f06wsqs=;
	b=gpcYpiAEHP+zcNzwy/azajOS0QokCObJB8cS7HRDojDfPNW6mQI11HElJktPC3J4ZdLsrD
	04lAClyTfJGb+Tr096ayxh9bkseGdZKMfKS/Cg/1Pu6B48HmFHGsXO8radonqt4HVzlpBN
	vvd9HA3IZgzWoqVkwk3ioYtt8N5UW0Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-RtZJsI5wNDaiD73_R6b9cg-1; Mon,
 03 Nov 2025 08:55:13 -0500
X-MC-Unique: RtZJsI5wNDaiD73_R6b9cg-1
X-Mimecast-MFC-AGG-ID: RtZJsI5wNDaiD73_R6b9cg_1762178112
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A98D195608D;
	Mon,  3 Nov 2025 13:55:12 +0000 (UTC)
Received: from localhost (unknown [10.64.240.25])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25C711800452;
	Mon,  3 Nov 2025 13:55:10 +0000 (UTC)
Date: Mon, 03 Nov 2025 22:55:08 +0900 (JST)
Message-Id: <20251103.225508.567794581853480571.yamato@redhat.com>
To: dick@mrns.nl
Cc: util-linux@vger.kernel.org
Subject: Re: reflink utils
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <176198657938.2807.15997469587039898204@routi.mrns.nl>
References: <176198657938.2807.15997469587039898204@routi.mrns.nl>
Organization: Red Hat Japan, K.K.
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi,

> Hi,
> 
> I've created some tools to work with reflinks (FICLONERANGE) which I'd
> like to include in the util-linux project.
> 
> Reflinks can be used to share equal blocks between files. Cloning a
> block using reflinks will not copy any data saving I/O and disk wear/
> space.
> 
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
> - are blkdiff, blkpatch and blkcat good names?
> - what's required more? I can image I need to add some man pages etc.

I have contributed to the util-linux project on multiple occasions.

I hope my commit 
https://github.com/util-linux/util-linux/pull/2627/commits/0d5f67b29ce487e9cfff7c8b16aa8f9e7c0e2d10
helps you. This may be one of the smallet commit that added a new
command to util-linux.

See also the commits added after the commit:
https://github.com/util-linux/util-linux/pulls?q=is%3Apr+is%3Aclosed+exch
They fixed my mistakes.

Masatake YAMATO

