Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF453E11
	for <util-linux@vger.kernel.org>; Sat, 18 May 2024 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716064803; cv=none; b=gvDYFXzn6yKipmANos8cv+SFi/d5x1v5cdL9TvoOM0omE3F5hCphTYOvgHysFhnMW/9txN7+DFqaUvg0uZmTxKig9ORpVxCW0yBD+isg5KRLUfRhkgBLnAEkjI/h7jvr4/CNW+s3CxHJSuui3XvJd09u6cM62Vqsxfdeb1DMe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716064803; c=relaxed/simple;
	bh=3jvU4yp4Gs/R7v8MrLf9wwzT+tZMjTKWq6usGT+xP6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=MgfRN8M+JCJUejj1owvD/0WxI7QMzRMX5X5oavrHzsvP7XvhRc9BUG/gCYJmqR3vcYuzMee18SM8MxHKI5AvQA3BYdVl+/M0u26V/0vs8q24iBwhlERHcqwTCcZVVyaHpDWt8PyAiEUpPlpOdRv1v/faUq4jcl0jEIw8gglMsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dvtOTEkN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dvtOTEkN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:In-Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To:Content-ID:Content-Description;
	bh=3jvU4yp4Gs/R7v8MrLf9wwzT+tZMjTKWq6usGT+xP6E=; b=dvtOTEkNPcrF8o4MXsDZKM27XU
	RMMRMtFJ/l57M56vp8s9Cd9hWkL+y97TwfYKv/x8jo3QlygaoKFS88p7Y/2uXoYcX/YHLcJSG7FGK
	ECXhTXP6R6rfPdzKjCZggZz5jEfCxIkZ/VcL3reaPL9mPQyFJjvePbEMA0XtsRTf6l/6bW556bMzg
	NbqVrQLexlKz58Wg8tO+XD1xPylIjKj0pgnE0BX9XHkIqvo/jgFUe/XG3ttrGQKkCZ8MhEXyXOW23
	ZKg6rVYDLgLpSXVD5UcBYkmff8QAEeGETF+L5WKwJnHTkwE4ZdEpB74NNAJmlzLS+UXsbW9Emb1jm
	Rf66Zvkw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.94.2)
	(envelope-from <sanvila@debian.org>)
	id 1s8QTF-00Acs7-Uu; Sat, 18 May 2024 20:15:58 +0000
Message-ID: <3dfa7d03-f2bf-4d6f-8387-98ec999243bf@debian.org>
Date: Sat, 18 May 2024 22:15:55 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Parallel build failures with util-linux 2.40
To: util-linux@vger.kernel.org
References: <87le4c1zm4.fsf@alyssa.is>
 <20240515142226.oyp37o3fkajvpoal@ws.net.home> <87eda31219.fsf@alyssa.is>
 <87v83auc95.fsf@alyssa.is>
Content-Language: en-US
From: Santiago Vila <sanvila@debian.org>
Cc: Alyssa Ross <hi@alyssa.is>, Karel Zak <kzak@redhat.com>
In-Reply-To: <87v83auc95.fsf@alyssa.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Debian-User: sanvila

Hello.

In some cases, make --shuffle option (available in GNU make 4.4)
"amplifies" the probability that a Makefile bug shows up.
I suggest that you people give it a try.

There is a blog entry from the author explaining --shuffle option:

https://trofi.github.io/posts/238-new-make-shuffle-mode.html

[ I'm just a long-time lurker in this list, but maybe this could help ]

Thanks.
