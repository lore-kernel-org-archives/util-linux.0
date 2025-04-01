Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D24B202C43
	for <util-linux@vger.kernel.org>; Tue,  1 Apr 2025 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510048; cv=none; b=QyeebJ2SpMWGdnjR6XK1sKVmKfC2+smONCCXf+Rt4hH1NoIUuRKyZt9pO1jQJsoCjuRkO6MKYxcruBq9cy04uIH0pxjO4jXa9NUVNK0CJveBEGb23cemOqSzrElE6YRV7HypDMhU4ljBxVrvHeADtjdAiaB2DxavUFc7+dJ2m0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510048; c=relaxed/simple;
	bh=HE+sznkM9/mw0/cfSxg/cKn/fZyrR8yKK+5ZU8hJL4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtDhHlj1a+7hMvwE40JI2lrxU7xkn452ygbP1fz/qsfSrFBJ6WWZPwybQcLfqazwrnC2JDf3NW+xwTCpsam3IRGYsZGnhQmgtlZhq4xzLk4kQ0GwRLPYbWiR7JlgH8iFB/8dYc2NPU1aUz72EOTMsi7VzEShsy1rNJxagxCDvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVge895j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVge895j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743510046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7HaymBgFA8rZd2kYZjwp21dPmxBGRDAAyV4XpBJZNps=;
	b=LVge895jLpuUlZRGpCr9cRUWHyAPZuT/j/WoViJmOZXHYRbAlx9bF8/ecEIayfmhtiua54
	M/q2KT7J54NT7Aj7LOpy5rSIQJYVJZ2Aw2uAbFlqlwlFYArGDl4eMV1/Vwq6s3Z30J6zqV
	cfatx6cZ6/Vb3TjIStikOSvpj/bma/8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-mau-pewIN-eufk4CAF4i4w-1; Tue,
 01 Apr 2025 08:20:44 -0400
X-MC-Unique: mau-pewIN-eufk4CAF4i4w-1
X-Mimecast-MFC-AGG-ID: mau-pewIN-eufk4CAF4i4w_1743510044
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9BAD1800266;
	Tue,  1 Apr 2025 12:20:43 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 667283001D0E;
	Tue,  1 Apr 2025 12:20:42 +0000 (UTC)
Date: Tue, 1 Apr 2025 14:20:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Phil Auld <pauld@redhat.com>, util-linux@vger.kernel.org, 
	Thijs Raymakers <thijs@raymakers.nl>
Subject: Re: [PATCH 10/10] coresched: rename option '--dest-type' to just
 '--type'
Message-ID: <lqubnzf67fuswi6iiovhwwiipahk5ysywe2xhp4tkbirzao67j@jkpnnwl6w2sx>
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-10-bensberg@telfort.nl>
 <20250331110902.GB120637@pauld.westford.csb>
 <tvh2bppxcinonxmyjrrgghgsylnaz6mkcrqr5ifxfqxvw54jym@iirtylnnzx4h>
 <a281e4be-2cd9-4d22-be86-502395556005@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a281e4be-2cd9-4d22-be86-502395556005@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Apr 01, 2025 at 11:25:40AM +0200, Benno Schulenberg wrote:
> 
> Op 01-04-2025 om 10:35 schreef Karel Zak:
> > On Mon, Mar 31, 2025 at 07:09:02AM -0400, Phil Auld wrote:
> > > but this could break users. There
> > > may not be that many yet anyway, of course.
> > 
> > It's already released, so it is truly a backward-incompatible change.
> 
> Users of a brand-new tool really should expect some iterations in the
> next versions to improve the feel of it.  So I don't see a problem in
> correcting a poor choice for a long-option name.

We've already discussed this, and --dest-type was chosen because
there's --source <pid> and --dest <pid>. We wanted to ensure users
understand the type relates to --dest. It's just an option name, so
let's not get into bike-shedding, please ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

