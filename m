Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695427586C
	for <util-linux@vger.kernel.org>; Tue,  1 Jul 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385311; cv=none; b=d5O//JQST1CB30T4cFfWOgMFIpgtz9JT33yGdmuDFESfV0Kl6f5FkF06bljKUqRg7wMGqsd18tGiU65WjWgXHY8VEEuX6gAX324UHk9d2Pj+y5KBhYuEdHlayqA0HDH5nEUp7CcZUaZxFRBOp0lqhd0sw1qb7QpnDX0fIFMG+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385311; c=relaxed/simple;
	bh=dF4fIbrvlo8eIBofRbiEDwaXC7hJcHfPeTuKpEMgd6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9++SfPf5vuACwhQk1vxFzbJu3jVlM+qaw8OEDawNWm5eco4sPeuqWA5XN8+jRnqnoWrQ/MAcWiBfs/C2FAkTjLbjpXcTHlGDenI3AGFNc2JWtGzt3ypEOJNlTtEKnD0fwsCocwEnXunsQixHH8NO1FQrLl6fhRTbvynLcPLjcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wm+Db2aL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wm+Db2aL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751385308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6aAHiAngAAcG76Qbnn6Uqm+cacIXnTEc0d5OHlVriEI=;
	b=Wm+Db2aLRx5nVlD2kXAfErcXrCO4u3jlPGN5ucZdVYzLl4fItt4B89J3czPsLga2nf28d+
	OI3L9F5P+l2QRXYM0wmtbv6yjQRR/VTMJ3OmWnb6nf75S3VBP27ra5jSDkvgphMr9hDVTI
	9h0A80IrcX2D2qxoNFWzZZ96kapcuyA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-U2P_gsFxOb-PEZ6ox02YgQ-1; Tue,
 01 Jul 2025 11:55:06 -0400
X-MC-Unique: U2P_gsFxOb-PEZ6ox02YgQ-1
X-Mimecast-MFC-AGG-ID: U2P_gsFxOb-PEZ6ox02YgQ_1751385305
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57627180120C;
	Tue,  1 Jul 2025 15:55:05 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5181E1956087;
	Tue,  1 Jul 2025 15:55:04 +0000 (UTC)
Date: Tue, 1 Jul 2025 17:55:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] chrt: (man) correct the short form of --ext, from -d
 to -e
Message-ID: <gkpvx2ade5tzdjsu7bqtwhd7uwpa7guc7jcaemw7ohcqh4vknb@w6h5ompjgi4x>
References: <20250625080948.6064-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625080948.6064-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Jun 25, 2025 at 10:09:47AM +0200, Benno Schulenberg wrote:
>  schedutils/chrt.1.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied (both patches), thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

