Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714E5230BCA
	for <util-linux@vger.kernel.org>; Mon, 17 Mar 2025 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206245; cv=none; b=Ev+3Qy9rVitzEt4+j2sPX7JFgAHf/TrWxuUAZWJady75KvJNsgdzddTjIVPOWHkBIqYsxO0Bji6GcdegHWjVqKnum7+Zz8q+jl34SsuNB8eGTkR5d9WY/QJcyEmuDiLDPe0XpXNMsdaUsFEtBqAKPb8CzJSpWkvyHQcUTgthwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206245; c=relaxed/simple;
	bh=wSR+SG8FOyd9Odg8k/3WqfgL3fVtkeVH/rp/JtbkUc4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=quBdGVqg0uCNfqaNfNyw4uK96So1x+35dhXURlX2dR/NRdvIW/uMU+gvKWliO1HpnmUrmC2nb+N5L6dZmlT7u6SExjI2V/tyffQZjxdkLFIfWkSQMuJDhoEWZEC7/447R9085dtVpDflKmdtWadUc+1As9YrUVTwMwZej8268XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ReUDnMo7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReUDnMo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742206240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=aT0swp6DFwRBBwWOqgcUnEJQXM0dzJau0+i253lb0W4=;
	b=ReUDnMo7Z2KhiODPxMzS5wXSf1NSbuiVgTWyuOaK+yZmdWT55NxP1/W43ncFwElvMAXdtO
	HH7qnPE4Puxnj1Z6Uc/xj+wrs98LhU7qn8jIW/PxM0DnwC2xDghHJDLFKXR5xKhphFClnb
	YSkIb3W8t9F/Kvzz3+zBJr3DmP/bL8c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-xdaXrYPqONKkzZq5-WCAgQ-1; Mon,
 17 Mar 2025 06:10:36 -0400
X-MC-Unique: xdaXrYPqONKkzZq5-WCAgQ-1
X-Mimecast-MFC-AGG-ID: xdaXrYPqONKkzZq5-WCAgQ_1742206236
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F2281801A1A;
	Mon, 17 Mar 2025 10:10:36 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4F1A18001D4;
	Mon, 17 Mar 2025 10:10:33 +0000 (UTC)
Date: Mon, 17 Mar 2025 11:10:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] irqtop,lsirq: set up locale path, so messages get
 actually translated
Message-ID: <ylfkyskoso3flajvar34jseshzbtmmya77wydit2bk4soyjihm@admpxxce2bpk>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316152040.44163-1-bensberg@telfort.nl>
 <20250316152040.44163-2-bensberg@telfort.nl>
 <20250316152040.44163-3-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Mar 16, 2025 at 04:20:37PM GMT, Benno Schulenberg wrote:
>  sys-utils/irqtop.c | 3 +++
>  sys-utils/lsirq.c  | 3 +++
>  2 files changed, 6 insertions(+)

On Sun, Mar 16, 2025 at 04:20:38PM GMT, Benno Schulenberg wrote:
>  text-utils/more.c | 1 -
>  1 file changed, 1 deletion(-)

On Sun, Mar 16, 2025 at 04:20:39PM GMT, Benno Schulenberg wrote:
>  disk-utils/cfdisk.8.adoc    | 4 ++--
>  disk-utils/fdisk.8.adoc     | 5 +----
>  disk-utils/swaplabel.8.adoc | 4 ++--
>  misc-utils/hardlink.1.adoc  | 3 +--
>  misc-utils/look.1.adoc      | 2 ++
>  misc-utils/lsblk.8.adoc     | 4 ++--
>  misc-utils/uuidgen.1.adoc   | 4 ++--
>  sys-utils/eject.1.adoc      | 4 ++--
>  sys-utils/lsmem.1.adoc      | 4 ++--
>  text-utils/bits.1.adoc      | 4 ++--
>  text-utils/rev.1.adoc       | 4 ++--
>  11 files changed, 20 insertions(+), 22 deletions(-)

All applied, thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

