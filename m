Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34030 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744AbbK0OWa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Nov 2015 09:22:30 -0500
Received: by wmvv187 with SMTP id v187so72933373wmv.1
        for <util-linux@vger.kernel.org>; Fri, 27 Nov 2015 06:22:29 -0800 (PST)
Received: from localhost (bigbear.stochastik.rwth-aachen.de. [137.226.106.91])
        by smtp.gmail.com with ESMTPSA id t2sm8499417wmt.1.2015.11.27.06.22.28
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Nov 2015 06:22:28 -0800 (PST)
Date: Fri, 27 Nov 2015 15:22:27 +0100
From: Evgenii Sovetkin <e.sovetkin@gmail.com>
To: util-linux@vger.kernel.org
Subject: bug in the cal
Message-ID: <20151127142227.GA28400@bigbear.stochastik.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello everyone,

just noticed a funny behaviour of the cal program...

% cal -n2
Produces calendar for November and December.

% cal -n3
Produces calendar for October, November and December.

% cal -n4
Produces calendar for November, December, January and February.

I don't think it is the expected output. The version of cal is from
util-linux 2.27.



Kind regards,

Jenya

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWWGciAAoJEK4/5DnRrdNLJfoP/2J5OWZfS2VHjs5SwVPsbHwf
wyU0U2TorSZTCRVDMKvg/wqW2MZ56C+OnAhToiI6N8lqFTzpHWbjH8Ab1oaLqLHI
deXiy+qGY3cmKQGgcqluHaMmeJuwfFqwb72IqMsfXLny05jg8L3eXbjP3USz/w/Z
rtsnyrPpA1D0liJpadaWtwXFLWSJs4ispDOg1/+0Z0RY7KW0QAK2QMErVa5HEfsO
grft+Fbz/LtaspPphKDPTcRvCRm4n79MoETos6XbdWxCNINlQJRrIvOydgsU34/7
/238hiMvTlaRXbG9lgVLGpxSchoFdgCzTNxu90CkTi565R+42MMOYoaTxBinumu5
friKmGRS+GMaKe6xrxzs4ucrtvzNa/W/exniimSaiS9iWRvqkRvGt4e5/g47Vuwc
oiNweouQraTOASA/XM5G54o38ExtBjqv8xthEzfSF9nY9PZeVz++5Y9XM+TUS13T
UrzeT6ja6QvfLic22vP3UAb5xGIiFBsIWYhf/R6g/NMfWmppvpzsM0meU06bDU4W
36xXh892EbjuswaeDEaLDO194S5HrnH0a+GzPKNf0i4jmWsSPiV/L1AIQ2I4Vv6y
1bARpMe8n8+1IumVlrTQa4rgldSoIcV8q51awcbvYOOVw3jRfojHw6j0ltuiIHhJ
61GAvrLttyfhUs7hlV2O
=2P6P
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
