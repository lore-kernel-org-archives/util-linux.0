Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64B38944A
	for <util-linux@vger.kernel.org>; Wed, 14 Jan 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382969; cv=none; b=IoPhhly6C2xXD4tLf0po/Qax3/oD6SayQvZ6xjxzvYvjmzCUpBdfyXMLtMjeyxll7fptRDQKLId5ZQ+jEoZXPcCMig3MUMBUtkYQTXDYxLqviAJqBpJ7DVtuo+SvCu7qEMLawoLa36eajwtyCuyF+wt2E9fErLP5Bs/lD4t5jSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382969; c=relaxed/simple;
	bh=0RuxCL5zBIFguHb39hXEQugp5yp37Ntj6FG3EuUOzZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8kdFqzUjVCFXcFjwyaMqVIK7ZkIe5SU5ptA1v6yua3FAWBwCKC5XW7XaoeXW3EFiKS/pTwRuSxc+bBj9X9j10u0AAQT41+eSWYu6GxWq8VGl2C0ZfsU8peTyND2TBKrOj++QeGgo3onYqeqscXjUU6X1/hwh2R7P6yK/jiMuok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ib3HQncm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ib3HQncm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768382967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=egitCqoPWwid8Fe+BOBcmLWtnyZdRr835gW8BnU1y3A=;
	b=ib3HQncmVLqyMCmbh8Q8L1/fHokLUiqWbdW3qskrCaeHI4G+8fSdmWq+3ywqeIHDVf2+TK
	QZXj9hxFVJjaBNsqTi/jJVxz6222OiHM3AxHBBpQk04nzALl/3O2l2Tfcw24oaolQFpMkG
	HVdGUttkbUWGAFrt30EoPZVjhw0mmco=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-vA5---oWMBaXRDGHR0yfNA-1; Wed,
 14 Jan 2026 04:29:22 -0500
X-MC-Unique: vA5---oWMBaXRDGHR0yfNA-1
X-Mimecast-MFC-AGG-ID: vA5---oWMBaXRDGHR0yfNA_1768382961
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7DE619560A5;
	Wed, 14 Jan 2026 09:29:20 +0000 (UTC)
Received: from ws (unknown [10.44.33.173])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D6B81956048;
	Wed, 14 Jan 2026 09:29:17 +0000 (UTC)
Date: Wed, 14 Jan 2026 10:29:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "slava@dubeyko.com" <slava@dubeyko.com>, 
	Alex Markuze <amarkuze@redhat.com>, "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, 
	Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [PATCH] mount: (manpage) add CephFS kernel client mount options
Message-ID: <urbvcc5r4fc6rsvwhikem73tbdmapvyy6mtrqbbl7vsdvoeis6@upwfm2u5jk3t>
References: <20260112205837.975869-2-slava@dubeyko.com>
 <binwryzqlbprj2t3ybxb5kychdeenhtmadbe23hov44urszvn5@kpbbv3qks47c>
 <c15ce83bf9ee6c5c37db193c33a77b52f0594564.camel@ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c15ce83bf9ee6c5c37db193c33a77b52f0594564.camel@ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jan 13, 2026 at 07:29:00PM +0000, Viacheslav Dubeyko wrote:
> My assumption was that if other file systems have description of specific mount
> options in this man page, then CephFS should have too. :) 

Unfortunately, some filesystems lack specific man pages, so mount.8
serves as a fallback solution for them. In an ideal world, mount.8
would not include filesystem-specific mount options.

I have added a link to mount.ceph in mount.8
https://github.com/util-linux/util-linux/commit/de7973f9906da09b86f221b030ec836c1e91fd22

Thank you for the suggestion!

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

