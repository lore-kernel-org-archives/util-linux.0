Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2s31+Wf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E277E4
	for <util-linux@vger.kernel.org>; Tue, 12 Dec 2023 01:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702374209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gakaEDRSbQ0CsF6sLA8szCRbcQvUFog0etys0KDJVvk=;
	b=h2s31+WfvIbfZFb/4O1TLpihkSZhDbcgigdNsphnqddqtH9Aic1h2YNsXXUOLGJFufj8UN
	8lpFiJBQmedFFBR8GltPioGIuuBl9BRe1EAWQzD6z4+2lDirHRFOozkyhoFgrD/C8/K2E2
	HQFE2wkSiVuF7AV/KViQw356R21Lyug=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-CX-W7vm3OmCIwXRhQ6-RJw-1; Tue, 12 Dec 2023 04:43:25 -0500
X-MC-Unique: CX-W7vm3OmCIwXRhQ6-RJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF5B088D58A;
	Tue, 12 Dec 2023 09:43:24 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B8631121306;
	Tue, 12 Dec 2023 09:43:24 +0000 (UTC)
Date: Tue, 12 Dec 2023 10:43:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Edward Chron <echron@arista.com>
Cc: util-linux@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH] Add dmesg syslog interface tests for PRINTK_CALLER field
Message-ID: <20231212094322.3hmnlez2iagcn5wd@ws.net.home>
References: <20231209222019.954-1-echron@arista.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209222019.954-1-echron@arista.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Sat, Dec 09, 2023 at 02:20:19PM -0800, Edward Chron wrote:
> Submission to Project: util-linux
> Open Incident: #2637 at github.com/util-linux/util-linux/issues/2637
> Component: util-linux/sys-utils
> File: dmesg.c
> Code level patch applied against: https://github.com/t-8ch/util-linux/
>      and we used his local-dmesg-tests from t8ch/dmesg/tests
>      as we needed the numerous improvements and fixes that Thomas has
>      made to the code.

Thomas' changes are merged in the master branch now. I have created a PR 
from your both patches: https://github.com/util-linux/util-linux/pull/2640

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

