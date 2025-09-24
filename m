Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF927FD64
	for <util-linux@vger.kernel.org>; Wed, 24 Sep 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701363; cv=none; b=DSOZ9FfvENEPsjt0POfDyf4QEpOfiKvWvZaDOOA9ER1ZL1A6E/36418foiaefHKz1pELi+VdjSStUNkE+2qBJad+YnPpSw7nh2/n22sV1DVjG9VG0uGMa2oJ2vA+i4jMYMBV+J2pLv4ZN/4uM80iLpLzqVlvlWy5LX4hHIaGJ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701363; c=relaxed/simple;
	bh=e1QQisjffygzfWML1aqF1YzwWEnCIQTEyOGoENVxLAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaeWYDQkULDxt6Td6qZXCeMLTvI2VyxBuxtuNiADGquR855xkMx2dgRTtego62oI8oSWOcipth+2y/xkob/WwpEuQJ5PI2a2ruCj4icP23wATUi/k9VaHiBtrIH/zEXWU234SC5DCx4fhjWURafE4plRs6umjTbdzKajiW3CNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVSJgbIa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVSJgbIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758701361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/hjULlCJAQs6PCWlTF9BoKU894yfRpxe6Fz4+jte8eQ=;
	b=jVSJgbIaD/kNBo7fd2QhJ/Cc+RJE9E3eN6qML+WLieCLxrMhXxNKZEo2bq0nmLOoFXux2f
	5KOKBjKL/cU8Ogz9Ww8hlLOQ28tZLkjWBL3lO81HsH7/VzEn9lIog1NfTlC8zrPOGH7c+0
	BKHm2/Gq2t6mjYh2qV7KclduSD35LzQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-CDygHIRXOQ-11kLV0knVLA-1; Wed,
 24 Sep 2025 04:09:16 -0400
X-MC-Unique: CDygHIRXOQ-11kLV0knVLA-1
X-Mimecast-MFC-AGG-ID: CDygHIRXOQ-11kLV0knVLA_1758701355
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 536291800285;
	Wed, 24 Sep 2025 08:09:15 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.252])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AAC018004A3;
	Wed, 24 Sep 2025 08:09:13 +0000 (UTC)
Date: Wed, 24 Sep 2025 10:09:10 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/6] getopt: (usage) make the description of -U fit
 within 80 columns
Message-ID: <4jfynomg46npjt5ruzqoh76kwgupuixcajbhgz57hwlkbil6nx@z4fsza5jk36w>
References: <20250918085707.41785-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918085707.41785-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Sep 18, 2025 at 10:57:02AM +0200, Benno Schulenberg wrote:
>  misc-utils/getopt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied (entire set). Thanks.
    
    Karel
    
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

