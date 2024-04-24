Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948FE158D79
	for <util-linux@vger.kernel.org>; Wed, 24 Apr 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951433; cv=none; b=fabKGuUrqhciLSTg55QXiu8lN3pbmZ8WlmZzdxqBHKNkI5BE6mvx8s0Y0PBY+5HdAziAzMzZ51iW5UQZAhuON6KXfYI2YLilrCyEPWxNTP/C0eza/xFsr14eV5/2bHnSPcCrUJfTfeDvqWrv8FZhJpS4PE+eVOV84WTL4H9VctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951433; c=relaxed/simple;
	bh=UyHaYKuuWmeIbAX72gXakxdeOEH3JWfYtDyLTdY55qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6j/hHC5Cx8ldoO2OCuN9ZeIAYeAQrZmGYu2SkXRftchquNAkx54ZElBcmd4YvH5gCeATIFYpr/jqNdZ+QBcO4xELV3N+jFoTa3Gvr4zxPF4RS3XA0AADaF1DFv42SmvZ0+uA2vPQhIKQ8hWgXXoseWEOhxTSKEMN3THR9qHvZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q77EGDdM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q77EGDdM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713951430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMW8PpAgZaE+R6YEXaT2znh4n4IHizumGHysZbcS8Ec=;
	b=Q77EGDdM8CbhGw60mnY3V8lbaevmgk9meVyhzFBrFez04lhkhk6lWXvJ1nzV8Odl9eb3YT
	LPWT4Z48Iuy5+R7HVERzXDZyv7LWtRDDIRbnLpAvhbqyrPtKOeBk058FMqdMt02LoM+P6Z
	6WQFu7CIR8ePD+90sLQxclPJg5QL2sA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-hQdGLyZjOwSAa6HMahc7TA-1; Wed, 24 Apr 2024 05:37:08 -0400
X-MC-Unique: hQdGLyZjOwSAa6HMahc7TA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDB2080D678;
	Wed, 24 Apr 2024 09:37:07 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 75BF82166B31;
	Wed, 24 Apr 2024 09:37:05 +0000 (UTC)
Date: Wed, 24 Apr 2024 11:37:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Mikko Rantalainen <mikko.rantalainen@peda.net>
Cc: util-linux@vger.kernel.org
Subject: Re: RFE: hardlink: support specifying max_size too?
Message-ID: <20240424093703.tiyoxp2guzfboq3h@ws.net.home>
References: <0aa615c2-8e17-4eb3-9a25-c8af39b35d81@peda.net>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0aa615c2-8e17-4eb3-9a25-c8af39b35d81@peda.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


 Hi Mikko,

On Tue, Apr 23, 2024 at 04:58:10PM +0300, Mikko Rantalainen wrote:
> I have huge directory hierarchies that I would like to run hardlink
> against but comparing a lot of files against each other results in high
> RAM usage because so much of the file metadata is kept in memory.

Good point. I have tried to optimize the content comparison (using the
kernel crypto API), but the binary tree is still the original
implementation and there is probably room for further optimization.

Perhaps storing all 'struct stat' information for every file is
excessive, as there is information that we do not need (such as atime,
ctime, st_blksize, st_blocks). Some information is only necessary if
respect_{mode,owner,time,xattrs} are enabled.

The tree also contains paths for all the files. If you have many
subdirectories or long directory names, there is a lot of duplicate
data in the binary tree. One possible solution could be to keep
directory paths in a separate hash table and only store pointers to
the names table in the metadata tree.

Another problem I see is that the hardlink keeps the entire
binary tree in memory during the second stage when it compares file
contents in the visitor() function. However, at this point, we do not
need the tree entries that are already unique and will never be used
to compare file contents.

> Could you add max_size (--maximum-size) option in addition to min_size
> (--minimum-size)? This would allow splitting the work into small
> fragments where hardlink only needs to process files in given range and
> immediately ignore all other files. Or it could be used to run full
> linking in multiple parallel tasks with sensible RAM requirements if you
> can run hardlink without size limitations (e.g. one task for 1–1MB
> files, another for 1MB–10MB and third task for files bigger than 10MB).

This is not a trivial task. It would be better to begin with
optimizing memory usage before implementing more invasive changes. 

I am unsure how you plan to compare all files if the metadata is
stored in multiple independent trees.

> It might also make sense to reorder the test for filesize and regex
> processing in inserter() because testing for size is probably faster
> because the stat() has already been made. Currently the stats.files is
> also increased for files that get ignored by size filter which may not
> be intentional.

Good point, send patch :-)

> I think I could provide patches if I just know which Git repo I should
> use as the basis. Is https://github.com/util-linux/util-linux the
> correct one?

Yes, GitHub is the best repository. You can also use it for pull
requests and reviews.

My suggestion is to add debug messages to see where the problem is,
calculate the size of metadata, the size of paths, and the size of
calculated data checksums. Please share the results.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

