Received: from mail.finaturafirm.pl (mail.finaturafirm.pl [51.195.117.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A3284694
	for <util-linux@vger.kernel.org>; Fri,  6 Jun 2025 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.195.117.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749196614; cv=none; b=HPKSlY4VYhR7dx6kSyPmDgUYZHQBdIz7tzcMi7SvO4BoB6OUsu/vvYMfOHmZcskmxPj8mj3X0eJ+3AXfnV/2nVPmY0NoabXsEjLUDjOu161gPJXJTEcsV8dWd1BCta2jx2++b1mKZ/qF7Jxy88byutD6csPa/ocNtyz8GBy7KHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749196614; c=relaxed/simple;
	bh=u03PXPZqpLunC7lg3SeYwyZTo/1semy27RofYJ97viA=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=F6/pz9v1bIzHBfxvl0Nq5Ko3NsVVdXxiSPuHKtu+hGxQ4+iUC0Fsde7afmp91xQrO5cH7H1dnjr3JeiQQ+lJ+JEba0tRqOHG9JTZZWLuawl6h43g4ZBKl8ngTIyxKatpTNGuWpzWLrhSHKSA8QHYbZjKq1hbe9sYj8la+gCtuR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=finaturafirm.pl; spf=pass smtp.mailfrom=finaturafirm.pl; dkim=pass (2048-bit key) header.d=finaturafirm.pl header.i=@finaturafirm.pl header.b=ZdYOX7HQ; arc=none smtp.client-ip=51.195.117.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=finaturafirm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finaturafirm.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finaturafirm.pl header.i=@finaturafirm.pl header.b="ZdYOX7HQ"
Received: by mail.finaturafirm.pl (Postfix, from userid 1002)
	id 5E47DA5F40; Fri,  6 Jun 2025 09:56:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=finaturafirm.pl;
	s=mail; t=1749196602;
	bh=u03PXPZqpLunC7lg3SeYwyZTo/1semy27RofYJ97viA=;
	h=Date:From:To:Subject:From;
	b=ZdYOX7HQtfU4oMYECR5aRFFhMgB0Eq0TDL8fES9vNVndTV1IfoRhyo9aW2OfMrP6S
	 c4rVtw3x4phEbBb41Zpnq1Vs6R2/eCN1xTwJEwHpuDMUDRo45pWiIFichkKrWRFkqE
	 w9uZY3EVdBARp3KXucGQAKwnai04xV+W7xY3tNiyMKhq9kkf5yB79J4kHfqOR3R73m
	 ONRrxclzrVkkLZNLXf3NibKdqFn7aaiXQhK3DrEPjTiYPImnLQsehDeYipfvUoxv0J
	 uQtangnPIad23m57xsqshI3qj9mnlSzBWn+BTg65hZswefL0tVnEARajMxzY1KMAfp
	 AX5XaVVKFG3QA==
Received: by mail.finaturafirm.pl for <util-linux@vger.kernel.org>; Fri,  6 Jun 2025 07:55:59 GMT
Message-ID: <20250606084500-0.1.kg.20ogn.0.so2m2o4dql@finaturafirm.pl>
Date: Fri,  6 Jun 2025 07:55:59 GMT
From: "Andrzej Chrobak" <andrzej.chrobak@finaturafirm.pl>
To: <util-linux@vger.kernel.org>
Subject: Zakup energii w modelu SPOT
X-Mailer: mail.finaturafirm.pl
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Szanowni Pa=C5=84stwo,

je=C5=9Bli oczekuj=C4=85 Pa=C5=84stwo obni=C5=BCenia rachunk=C3=B3w za en=
ergi=C4=99 elektryczn=C4=85 i poszukuj=C4=85 elastycznego modelu zakupowe=
go, to my=C5=9Bl=C4=99, =C5=BCe zainteresuje Pa=C5=84stwa nasze rozwi=C4=85=
zanie.

Specjalizujemy si=C4=99 w sprzeda=C5=BCy energii elektrycznej w oparciu o=
 godzinowe ceny Rynku Dnia Nast=C4=99pnego Towarowej Gie=C5=82dy Energii,=
 znane r=C3=B3wnie=C5=BC jako rynek SPOT.=20

Dzi=C4=99ki modelowi RDN maj=C4=85 Pa=C5=84stwo mo=C5=BCliwo=C5=9B=C4=87 =
obni=C5=BCenia rachunk=C3=B3w i wyeliminowania ryzyka wysokich sta=C5=82y=
ch op=C5=82at w d=C5=82ugim okresie. Dodatkowo nie ma konieczno=C5=9Bci d=
eklaracji zu=C5=BCycia, a ewentualne zmiany nie poci=C4=85gaj=C4=85 za so=
b=C4=85 kar finansowych.

Zapraszamy do skorzystania z naszego wsparcia, kt=C3=B3re pozwoli Pa=C5=84=
stwu zaoszcz=C4=99dzi=C4=87 i mie=C4=87 kontrol=C4=99 nad cen=C4=85 energ=
ii, bez potrzeby podpisywania d=C5=82ugoterminowych um=C3=B3w.=20

Czy chcieliby=C5=9Bcie Pa=C5=84stwo om=C3=B3wi=C4=87 szczeg=C3=B3=C5=82y =
takiej oferty?


Pozdrawiam
Andrzej Chrobak
