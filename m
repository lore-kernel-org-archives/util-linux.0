Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146F139AE3
	for <util-linux@vger.kernel.org>; Wed, 20 Mar 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945862; cv=none; b=hQraixqvEedYtVBdfugk5WzX3+XQ+9XLyNGlCMzf97kJaebRyD4uAw3rP7WTkwqeM7ehZOME5wYmPsqCAkfHabct0R0FeaSp/YXYRt9vKo7ceHB+WlP+ZIXeC6596Y7gX3UqsZCBt+z5yo7znf+PNW/Mz96EzJ/kwAlB32FDWVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945862; c=relaxed/simple;
	bh=v95QORQRYHuerObtNPb8hEuW5M/wUBSS2wqXeNXcdxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYhKFzvKEcoSdqq1GpJGwlDYbYSX51WIVFJgOqJCISR5Rmq6IblqvpO2i/4YGun57CsNo4ffLHdqaAyiP1COkVFskhwonOnlj6S21oR2cSdBbDGy3G7tjhawb0/0DiSPva9sLNzwF98oceYxRcu+elRQDWus9rUsbvGJYK3w+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TScOuEAD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TScOuEAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710945860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnS2CJOmI00PqiJBxnjBiBxXjUxyIsbAuDVu19PuvjA=;
	b=TScOuEAD6E8JjWumwmpJpuwDy4ZxUulAozuNdE9afCoaTWkwbNddEOYWDh+x4pjCkR1bbO
	t/rQMsXaVdc3OG3adFbC73smUvLeGlgTqR+SGYEOOlcMy7H5LWj1VdnBs8qhH7Tnx16JDh
	HHI+HyALG24eY45Dzzjc+ZgvA15WOEs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-u1lFq-znNAWnIXZLla_d6A-1; Wed,
 20 Mar 2024 10:44:16 -0400
X-MC-Unique: u1lFq-znNAWnIXZLla_d6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C97FB28C97D6;
	Wed, 20 Mar 2024 14:44:15 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.242.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DBEC200E1AD;
	Wed, 20 Mar 2024 14:44:14 +0000 (UTC)
Date: Wed, 20 Mar 2024 15:44:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
	Heikki Ylipiessa <heikki.ylipiessa@suse.com>
Subject: Re: [PATCH] chcpu(8): document limitations of -g
Message-ID: <20240320144408.fckpwedymzm4qiz6@ws.net.home>
References: <52efc277-463c-441e-8284-595cefa254e9@suse.cz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52efc277-463c-441e-8284-595cefa254e9@suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Mon, Mar 18, 2024 at 06:39:36PM +0100, Stanislav Brabec wrote:
>  sys-utils/chcpu.8.adoc | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

