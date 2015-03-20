Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.otvi.nl ([178.21.19.65]:40008 "EHLO mail.otvi.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242AbbCTNet (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 20 Mar 2015 09:34:49 -0400
Received: from x174020.tudelft.net ([131.180.174.20])
	by mail.otvi.nl with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <work@otvi.nl>)
	id 1YYwpO-000112-Sl
	for util-linux@vger.kernel.org; Fri, 20 Mar 2015 14:19:06 +0100
Message-ID: <550C1E49.3000509@otvi.nl>
Date: Fri, 20 Mar 2015 14:19:05 +0100
From: Otto Visser <work@otvi.nl>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [libfdisk] incorrect GPT header leads to segfault
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms090603000507040701080402"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms090603000507040701080402
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[note: this is a more or less an adapted copy-paste from
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D780834; now tested
with the source of 2.26.1 instead of with the Debian testing version
2.25.2-5]:


Dear Maintainer,

Let's start with the TL;DR version:
if (lib)fdisk encounters a GPT header with an incorrect size field it
tries to calculate the CRC32 over whatever this size field is
reporting, leading eventually to a segfault.


Longer version:
I'm creating my own hobby OS (including bootloader part; not using GRUB
or anything) and was moving from start execution at first byte of the
HDD to having an actual partition table etc. Instead of using partx to
create the protective MBR and the GPT for my disk image, I decided I
wanted to learn what this GPT looks like and included creating the
MBR/GPT in the Makefile/linker script for the boot loader. I
misinterpreted the part where it said that the size field of the GPT
header is little endian and accidentally created a big endian version,
so my header is not 92 bytes, but a whole lot more. I then thought that
the quickest way to get the CRCs correct(ed) was to probably run fdisk
and let it calculate and fix my CRCs. To my surprise however, it just
segfaulted without any error/warning.


I downloaded the source code (version 2.26.1), compiled with debugging
and got the following trace:

/local/svn/util-linux-2.26.1/.libs$ LD_LIBRARY_PATH=3D.:$LD_LIBRARY_PATH
gdb ./fdisk
GNU gdb (Debian 7.7.1+dfsg-5) 7.7.1
Copyright (C) 2014 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying=
"
and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./fdisk...done.
(gdb) set args -l /local/OS/img_breaks_fdisk
(gdb) run
Starting program: /local/svn/util-linux-2.26.1/.libs/fdisk -l
/local/OS/img_breaks_fdisk

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7bb5206 in crc32 (seed=3D4294967295, buf=3D0x61d260 "EFI PART"=
,
len=3D1543381600) at lib/crc32.c:112
112                     crc =3D crc32_tab[(crc ^ *p++) & 0xff] ^ (crc >> =
8);
(gdb) bt
#0  0x00007ffff7bb5206 in crc32 (seed=3D4294967295, buf=3D0x61d260 "EFI
PART", len=3D1543381600) at lib/crc32.c:112
#1  0x00007ffff7badc6a in count_crc32 (buf=3D0x61d260 "EFI PART",
len=3D1543503872) at libfdisk/src/gpt.c:799
#2  0x00007ffff7badd47 in gpt_check_header_crc (header=3D0x61d260,
ents=3D0x0) at libfdisk/src/gpt.c:838
#3  0x00007ffff7bae0ca in gpt_read_header (cxt=3D0x61a080, lba=3D1,
_ents=3D0x61a220) at libfdisk/src/gpt.c:957
#4  0x00007ffff7baec01 in gpt_probe_label (cxt=3D0x61a080) at
libfdisk/src/gpt.c:1317
#5  0x00007ffff7b8ec5f in fdisk_probe_labels (cxt=3D0x61a080) at
libfdisk/src/label.c:49
#6  0x00007ffff7b91524 in fdisk_assign_device (cxt=3D0x61a080,
fname=3D0x7fffffffe409 "/local/OS/img_breaks_fdisk", readonly=3D1)
    at libfdisk/src/context.c:528
#7  0x000000000040b527 in print_device_pt (cxt=3D0x61a080,
device=3D0x7fffffffe409 "/local/OS/img_breaks_fdisk", warnme=3D1, verify=3D=
0)
    at disk-utils/fdisk-list.c:243
#8  0x00000000004087ed in main (argc=3D3, argv=3D0x7fffffffe0c8) at
disk-utils/fdisk.c:832


I then made the following (ordering) change in libfdisk/src/gpt.c:

956a957,961
>       /* make sure header size is between 92 and sector size bytes */
>       hsz =3D le32_to_cpu(header->size);
>       if (hsz < GPT_HEADER_MINSZ || hsz > cxt->sector_size)
>               goto invalid;
>
973,977d977
<               goto invalid;
<
<       /* make sure header size is between 92 and sector size bytes */
<       hsz =3D le32_to_cpu(header->size);
<       if (hsz < GPT_HEADER_MINSZ || hsz > cxt->sector_size)

Although this fixes getting the segfault, it still means that fdisk
concludes there is no GPT label, despite that the signature is clearly
there; hence I wouldn't want to call this an actual patch.

Whether this is a patch or not probably boils down to the question how
much of an effort should be done at trying to fix a GPT; my personal
opinion is that an effort should be made if the signature is found; the
user still has the option then to write the suggested changes, start a
new GPT label or quit the program.


Best regards,

Otto Visser.


--------------ms090603000507040701080402
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIMTjCC
BhIwggT6oAMCAQICAwn3LzANBgkqhkiG9w0BAQsFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNV
BAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRl
IFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlh
dGUgQ2xpZW50IENBMB4XDTE0MDUxNTIxMDMwMVoXDTE1MDUxNzAyMjMwMFowNDEVMBMGA1UE
AwwMd29ya0BvdHZpLm5sMRswGQYJKoZIhvcNAQkBFgx3b3JrQG90dmkubmwwggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDKYjr6HnHEWfUHlq7tlwr/N33uWQbvnuRTTxvs7WQO
4keiotkZKy1yDpK0Q1+JEVXC4hR08hiZQhSc7T4N0GiTMDIC94Jq57nyjDifQ+1RCaYvqjYC
HwNMpJmudRrcBuPbCZ12lyHtZr6e6Z6DKua1X7vB+W/ldqLAWSZ+QVCtXbv6luZu1SAjHvpb
LUwtZUMYA2r1esefxFhH9CP7FeSudufIiotU870JnNZXyKivnEdKFdFHY8CZaSJJJ9bV+o1D
/IkGIFwL5ne9lzkzvKXz1YZPJqeJdPqujXmnQkWYalL6Zk5GxWml504ngKSkFLuwb+6xJSQU
NvkXg1z3IQ2vAgMBAAGjggLSMIICzjAJBgNVHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNVHSUE
FjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHQYDVR0OBBYEFBF28GMs4yJYzUvdEm4pSkcheFJ/
MB8GA1UdIwQYMBaAFFNy7ZKc4NrLAVx8fpY1TvLUuFGCMBcGA1UdEQQQMA6BDHdvcmtAb3R2
aS5ubDCCAUwGA1UdIASCAUMwggE/MIIBOwYLKwYBBAGBtTcBAgMwggEqMC4GCCsGAQUFBwIB
FiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMIH3BggrBgEFBQcCAjCB6jAn
FiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgEBGoG+VGhpcyBjZXJ0aWZp
Y2F0ZSB3YXMgaXNzdWVkIGFjY29yZGluZyB0byB0aGUgQ2xhc3MgMSBWYWxpZGF0aW9uIHJl
cXVpcmVtZW50cyBvZiB0aGUgU3RhcnRDb20gQ0EgcG9saWN5LCByZWxpYW5jZSBvbmx5IGZv
ciB0aGUgaW50ZW5kZWQgcHVycG9zZSBpbiBjb21wbGlhbmNlIG9mIHRoZSByZWx5aW5nIHBh
cnR5IG9ibGlnYXRpb25zLjA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLnN0YXJ0c3Ns
LmNvbS9jcnR1MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsGAQUFBzABhi1odHRw
Oi8vb2NzcC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2EwQgYIKwYBBQUHMAKG
Nmh0dHA6Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xpZW50LmNhLmNy
dDAjBgNVHRIEHDAahhhodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQELBQAD
ggEBAHu8qRa9O0d3yz8GgNkZNCyIzhUrtzGzmKvoa/UgxznbupXz/hcEUINaU9CtyfnsTm31
Hnk9CtVNOlDhoxrVkVVU783U6Mx5aVQDYimt79F5B1zFr04TSENnwsbGXtKZilSumaHFqytK
HxzFvxhyOLi3AFb3JXyTttxQonQ/x+go/1FE76O8LJJcndWYYrpPzbmMdQ1Th+VSM6GMcGd8
eczhlOzhr6a3/5QTVAIK6pOpem1XkV0ye+qV8HWA804DymObI4RCKNtJ7dcyfFD75SPkC7du
+bTNOBketNSsUWzWCHa8A3DIvfq2WTyqMsdokUc7MWhLggj7MEJYESndgLMwggY0MIIEHKAD
AgECAgEeMA0GCSqGSIb3DQEBBQUAMH0xCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENv
bSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMSkw
JwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0wNzEwMjQyMTAx
NTVaFw0xNzEwMjQyMTAxNTVaMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20g
THRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYG
A1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0Ew
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDHCYPMzi3YGrEppC4Tq5a+ijKDjKaI
QZZVR63UbxIP6uq/I0fhCu+cQhoUfE6ERKKnu8zPf1Jwuk0tsvVCk6U9b+0UjM0dLep3ZdE1
gblK/1FwYT5Pipsu2yOMluLqwvsuz9/9f1+1PKHG/FaR/wpbfuIqu54qzHDYeqiUfsYzoVfl
R80DAC7hmJ+SmZnNTWyUGHJbBpA8Q89lGxahNvuryGaC/o2/ceD2uYDX9U8Eg5DpIpGQdcbQ
eGarV04WgAUjjXX5r/2dabmtxWMZwhZna//jdiSyrrSMTGKkDiXm6/3/4ebfeZuCYKzN2P8O
2F/Xe2AC/Y7zeEsnR7FOp+uXAgMBAAGjggGtMIIBqTAPBgNVHRMBAf8EBTADAQH/MA4GA1Ud
DwEB/wQEAwIBBjAdBgNVHQ4EFgQUU3Ltkpzg2ssBXHx+ljVO8tS4UYIwHwYDVR0jBBgwFoAU
TgvvGqRAW6UXaYcwyjRoQ9BBrvIwZgYIKwYBBQUHAQEEWjBYMCcGCCsGAQUFBzABhhtodHRw
Oi8vb2NzcC5zdGFydHNzbC5jb20vY2EwLQYIKwYBBQUHMAKGIWh0dHA6Ly93d3cuc3RhcnRz
c2wuY29tL3Nmc2NhLmNydDBbBgNVHR8EVDBSMCegJaAjhiFodHRwOi8vd3d3LnN0YXJ0c3Ns
LmNvbS9zZnNjYS5jcmwwJ6AloCOGIWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL3Nmc2NhLmNy
bDCBgAYDVR0gBHkwdzB1BgsrBgEEAYG1NwECATBmMC4GCCsGAQUFBwIBFiJodHRwOi8vd3d3
LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMDQGCCsGAQUFBwIBFihodHRwOi8vd3d3LnN0YXJ0
c3NsLmNvbS9pbnRlcm1lZGlhdGUucGRmMA0GCSqGSIb3DQEBBQUAA4ICAQAKgwh9eKssBly4
Y4xerhy5I3dNoXHYfYa8PlVLL/qtXnkFgdtY1o95CfegFJTwqBBmf8pyTUnFsukDFUI22zF5
bVHzuJ+GxhnSqN2sD1qetbYwBYK2iyYA5Pg7Er1A+hKMIzEzcduRkIMmCeUTyMyikfbUFvIB
ivtvkR8ZFAk22BZy+pJfAoedO61HTz4qSfQoCRcLN5A0t4DkuVhTMXIzuQ8CnykhExD6x4e6
ebIbrjZLb7L+ocR0y4YjCl/Pd4MXU91y0vTipgr/O75CDUHDRHCCKBVmz/Rzkc/b970MEeHt
5LC3NiWTgBSvrLEuVzBKM586YoRD9Dy3OHQgWI270g+5MYA8GfgI/EPT5G7xPbCDz+zjdH89
PeR3U4So4lSXur6H6vp+m9TQXPF3a0LwZrp8MQ+Z77U1uL7TelWO5lApsbAonrqASfTpaprF
VkL4nyGH+NHST2ZJPWIBk81i6Vw0ny0qZW2Niy/QvVNKbb43A43ny076khXO7cNbBIRdJ/6q
QNq9Bqb5C0Q5nEsFcj75oxQRqlKf6TcvGbjxkJh8BYtv9ePsXklAxtm8J7GCUBthHSQgepbk
OexhJ0wP8imUkyiPHQ0GvEnd83129fZjoEhdGwXV27ioRKbj/cIq7JRXun0NbeY+UdMYu9jG
fIpDLtUUGSgsg2zMGs5R4jGCA90wggPZAgEBMIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UE
ChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUg
U2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0
ZSBDbGllbnQgQ0ECAwn3LzAJBgUrDgMCGgUAoIICHTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0xNTAzMjAxMzE5MDVaMCMGCSqGSIb3DQEJBDEWBBSRoyQz
ZtvYFxQAmEFFO1NaboN0HTBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIHMA0GCCqGSIb3DQMCAgEoMIGlBgkrBgEEAYI3EAQxgZcwgZQwgYwxCzAJBgNVBAYTAklM
MRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0
aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAxIFByaW1hcnkgSW50
ZXJtZWRpYXRlIENsaWVudCBDQQIDCfcvMIGnBgsqhkiG9w0BCRACCzGBl6CBlDCBjDELMAkG
A1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdp
dGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJp
bWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMJ9y8wDQYJKoZIhvcNAQEBBQAEggEADGOu
BN7xWe3pt6+xtmZ7toKz3xtQnXLxT9t5yzBaYZV7qBzYGGKky5cT4MQDBtLP8298+bjRJo09
dgVHwfp8l6Nr/JK0IFbSCWE8+pZNf1peIayaunHHulix16UDoUA2QGDJgl8ptjJ/61mKzeWX
8XdEwVtA7wXmBS02qwubhkIGXNzRsXrBnU+a7AhBnl9sfeeqx9HssLt8GZI+gibobcsI27Ay
WFwGjiYcL39BR1Nnvixi86zGx0/fIQWw3r4uUeLVbrVroFgx7g0aK8QPYPoxoU4rWa6SOdaa
qnOczrIf299SEpjqXGIrlq3KKehnpMix2Lcjdq6ZOlw6SmihBwAAAAAAAA==
--------------ms090603000507040701080402--
