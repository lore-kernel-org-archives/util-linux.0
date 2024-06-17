Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABDA197A88
	for <util-linux@vger.kernel.org>; Mon, 17 Jun 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628875; cv=none; b=mFH6S3FDB81jXQvcK5cOjMppinsKiJqi/6YxrJMv8f0I0ELzl3DaH1zE/CDrmU+SafWZ7+rm1vmpjxNoh7hvqGh6Cu0GwUMTjyDdStFyN+VRxsszQLsW7AuGqKJnSzVK2jTANCg8HR+9XO4Esc8K0fDjLUhQPzdzE7cdOIkmeCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628875; c=relaxed/simple;
	bh=JqGCmobSGeuyiZNoM9v+2a3C6W+v9378mdV99NI11MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/qdByeZ13cG32n6yCi3FbhIbdwA7Zd/z36L2RM0J60XKTPWsf5GhoORPXw3KNH4GW2hg3acFX1sceXmAZW0Jdrpk8Bq4ooekyp4J6rJ6huQ0YcsAzwF7EynG0IwNZL0I738SEktDecqODA44gzmCwq/NBJUt3uq8/xzyVfAI6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fD5QgAKS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fD5QgAKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718628872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bkQb2TxKjBz9W5Y0IvHRBkomsziN2qNO8uyCjZftz8=;
	b=fD5QgAKSyO1eaOpNZCG5ZqGEBfL/PFuiknuwJJBx5UoQ0lk+6EbtAiJmVnX0ubOI7ub+D3
	hKT13iIGJnxhexU3d+mZKDrPGJJzPtmEm8yTFEvplpVKC5gx6hDsfi2ybN+4BSnKxDwbI3
	uCksqMXm1hycZ4EP5Cl0RuzlhDffYkA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-vgo84CWkPu2xZ_GRjLSXrA-1; Mon,
 17 Jun 2024 08:54:30 -0400
X-MC-Unique: vgo84CWkPu2xZ_GRjLSXrA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEAD919560A7;
	Mon, 17 Jun 2024 12:54:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.185])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B80B119560AE;
	Mon, 17 Jun 2024 12:54:27 +0000 (UTC)
Date: Mon, 17 Jun 2024 14:54:24 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] mount, losetup: Document loop destroy behavior
Message-ID: <20240617125424.6mzmwdczldgonbl3@ws.net.home>
References: <8c649c26-93de-4edb-8dec-c87c243ee45d@suse.cz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c649c26-93de-4edb-8dec-c87c243ee45d@suse.cz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Jun 11, 2024 at 02:15:36AM +0200, Stanislav Brabec wrote:
> The loop device detach runs asynchronously in the background. It can cause
> unexpected errors. Document the possible existence of the loop device after
> exit of losetup -d or umount and need of "udevadm settle".
> 
> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> ---
>  sys-utils/losetup.8.adoc | 2 +-
>  sys-utils/umount.8.adoc  | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

It failed to apply the patch. Did you send it through git-send-email?

    Karel

Warning: Patch sent with format=flowed; space at the end of lines might be lost.
Applying: mount, losetup: Document loop destroy behavior
error: corrupt patch at line 11
Patch failed at 0001 mount, losetup: Document loop destroy behavior

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

