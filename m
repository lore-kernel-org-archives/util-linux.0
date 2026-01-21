Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7BE3AE71B
	for <util-linux@vger.kernel.org>; Wed, 21 Jan 2026 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984670; cv=none; b=M0HZVJx2wicRTpWMz95tpHU+V5zVTFOqYVcrfuYtVGFHs4qpG6ZNMGN3qk9dkq67FpBTaQMRijC1S5XAnZ737EvTHFZZevh++WshrTkFV1txNDgEnt3htymiHiPa86xNjFMPpxmDh/RvYLzqA8rVrsiU0l8OW2Q3GpAC3Vm7QoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984670; c=relaxed/simple;
	bh=AIhyzkNt2MNHWGTf+P2aajYcGHutRLcCngz7KMcw0UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFTNUhFSpDwFIrlngc4X9gtUk4/TYZNyOpVRHH/+EoTonr4iza6LnM9imSH2xCQpemfrB7qsLxYx6H6EcriJn0iUnJT6g8nUeSExbwcpdtkMry+Q4NJoY2RKM3JAj2hT+pYNug/GeLZ9DrazFC6HOzRoEJy/Hj/JXb/y6aXDIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KcFyl2Qk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcFyl2Qk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768984666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8J6+TV8a+Z51Y0G0FAuGMqZnpN4y3wdzVHGSSAFueLM=;
	b=KcFyl2QkuM7w38X4Tk9pYKljbH6FMw5ttj4hoDilRDeFYZB0GIUjTi/T7j99ekOCQ/ZecY
	tKeQQCb177Gz5zUXDHJYikVG8aip5XOw+zVQybMYZLiBBfnuDW+ilPCg47DWOGKyTTWkPc
	Cu7CZ6F7BLwxFAPJHr7mzxmxehHNeEM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-gN97B19EP5OhQ-v5xOp4VA-1; Wed,
 21 Jan 2026 03:37:43 -0500
X-MC-Unique: gN97B19EP5OhQ-v5xOp4VA-1
X-Mimecast-MFC-AGG-ID: gN97B19EP5OhQ-v5xOp4VA_1768984662
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DA8B1956054;
	Wed, 21 Jan 2026 08:37:42 +0000 (UTC)
Received: from ws (unknown [10.45.225.210])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D33819560A2;
	Wed, 21 Jan 2026 08:37:41 +0000 (UTC)
Date: Wed, 21 Jan 2026 09:37:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Kiran Rangoon <kiranrangoon0@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH V3 0/4] unshare: add --forward-signals option
Message-ID: <7ulj72mcp6yiwukxk7uwwnj2mee6q35fkricd3dvlvhp7w5slk@f357o4cptqdk>
References: <20260113172942.10678-5-kiranrangoon0@gmail.com>
 <20260116170648.26439-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116170648.26439-1-kiranrangoon0@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Jan 16, 2026 at 12:06:44PM -0500, Kiran Rangoon wrote:
>  bash-completion/unshare                       |  1 +
>  sys-utils/unshare.1.adoc                      | 13 ++++
>  sys-utils/unshare.c                           | 64 ++++++++++++++--
>  tests/expected/unshare/forward-signals        |  1 +
>  .../unshare/forward-signals-kill-child        |  1 +
>  tests/ts/unshare/forward-signals              | 73 ++++++++++++++++++
>  tests/ts/unshare/forward-signals-kill-child   | 74 +++++++++++++++++++
>  7 files changed, 222 insertions(+), 5 deletions(-)
>  create mode 100644 tests/expected/unshare/forward-signals
>  create mode 100644 tests/expected/unshare/forward-signals-kill-child
>  create mode 100755 tests/ts/unshare/forward-signals
>  create mode 100755 tests/ts/unshare/forward-signals-kill-child

Applied, thanks.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

