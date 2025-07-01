Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48F51DE8A8
	for <util-linux@vger.kernel.org>; Tue,  1 Jul 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385359; cv=none; b=Cuo/s8mam2BBvVLpcm4NS2OSqnWvMF7VED/SNoh2MMmXxYcU7oe5si8GBFIV8lsUeyUiGCmqDjcswqRA25wixgNXIgVesH/LWwb8u2DF/4zjfqlgs5IW4kLCCWUN98yCagxph3+RQSCpJCPCiaOmTUTrvnUwJ0ODrQR19M+2S/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385359; c=relaxed/simple;
	bh=O/EM+8YEIMrJQw4MQCF/Ukwxmk+ara+Qvn+eohBkOIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMwoAFhWn3R4GHpgXW6xoyz9RafzjQAHAYTBZlT91/cShbwD1+B4OzybaqPUskZnGjRQGvGOLX0GMrZg4aYu1OjClRNqC9lbk7AVqGHuehwUfRuOaLg0X6EfS97X1MZiNn/fi/3IB9iVaN/gbn7a8Gl48XQwGI+YFKyHEBj8Xto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkSz5hdN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkSz5hdN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751385356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kKJBrCRKiDWzrot09q6AuOTyV7/7Q1JeOhrTeRZ00U4=;
	b=LkSz5hdNRJ+PYnM+B3hYWeqS+rprLKuOe+iBSCXeiDNiJjDqBrKxINWeMom2rnaM7di1T7
	VcyXObCI0q5P/VSoDBLlUhPXCWJBKiFgpMKG7rXxkVOEX7ahO1HbCqKsNtFBPmzHBTbhP9
	QQP577LXyPz+DWvQeMzmQO45Xkdcw4g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-dbvY-yA6Pgm5nUmMcKflqg-1; Tue,
 01 Jul 2025 11:55:53 -0400
X-MC-Unique: dbvY-yA6Pgm5nUmMcKflqg-1
X-Mimecast-MFC-AGG-ID: dbvY-yA6Pgm5nUmMcKflqg_1751385352
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C857419560A2;
	Tue,  1 Jul 2025 15:55:51 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9575195608F;
	Tue,  1 Jul 2025 15:55:49 +0000 (UTC)
Date: Tue, 1 Jul 2025 17:55:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, WanBingjiang <wanbingjiang@webray.com.cn>
Subject: Re: [PATCH 1/2] script: (man,usage) correct the markup of the
 synopsis
Message-ID: <v7k6nutg2gmc3wwqd7gcepnbbuejdkd7rir5425x7vsd3whoxd@bkvezvbt4uvo>
References: <20250627120408.11036-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627120408.11036-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Jun 27, 2025 at 02:04:07PM +0200, Benno Schulenberg wrote:
>  term-utils/script.1.adoc | 5 +++--
>  term-utils/script.c      | 8 ++++----
>  2 files changed, 7 insertions(+), 6 deletions(-)

Applied (both patches), thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

