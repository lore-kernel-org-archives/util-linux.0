Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7456C4418
	for <util-linux@vger.kernel.org>; Thu, 23 Nov 2023 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iW/gU6CW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A9AC433C8;
	Thu, 23 Nov 2023 02:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700708011;
	bh=rRbIXqjq8DKBA6vW+7glleky65j8TQodsqrm6IeWtY0=;
	h=Date:From:To:Subject:From;
	b=iW/gU6CWzFh+dJUuukgwoI+C7H5ahZEpCLMunedNRSjpyiffIwup/ktWT2Km6x2X0
	 xLTrrAYT6qC3gN2gtyX8BGzZ/bzP23YwCHQGmZk+7HbhTn72tjovxMZ/EU9VVtUMTp
	 m67df5sQKN0bPxM0Lhf54jR/9og/1L9fE7goBjD8=
Date: Wed, 22 Nov 2023 21:53:30 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: util-linux@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231122-outstanding-vehement-hornet-76acff@nitro>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to the new vger infrastructure. No action is
required on your part and there should be no change in how you interact with
this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K
