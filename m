Return-Path: Bartlomiej.Solarz-Niesluchowski@wit.edu.pl
Subject: Re: label-id and sfdisk problem
To: Karel Zak <kzak@redhat.com>
References: <a1e37c78-0162-2c2a-813e-1b1abee27fcb@wit.edu.pl>
 <20170221164928.geha65vjytxjsed5@ws.net.home>
Cc: util-linux@vger.kernel.org, Lukasz Trabinski <lukasz@trabinski.net>
From: =?UTF-8?Q?Bart=c5=82omiej_Solarz-Nies=c5=82uchowski?=
 <Bartlomiej.Solarz-Niesluchowski@wit.edu.pl>
Message-ID: <64bb45d8-dfe2-caf2-e451-2009302d0932@wit.edu.pl>
Date: Tue, 21 Feb 2017 17:58:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170221164928.geha65vjytxjsed5@ws.net.home>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070501070103010702080202"
List-ID: <util-linux.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms070501070103010702080202
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

W dniu 2017-02-21 o 17:49, Karel Zak pisze:
> On Tue, Feb 21, 2017 at 05:31:25PM +0100, Bart=C5=82omiej Solarz-Nies=C5=
=82uchowski wrote:
>> Dear List,
>>
>> I have problem with setting label-id of dos partition table
>> The problem occurs when i use sfdisk:
>> 1. I "save" the partition table with sfdisk -d /dev/sda > saved.table =
(saved
>> file has label-id of partition table)
>> 2. then i restore this via sfdisk /dev/sda < saved.table
>> BUT
>> label-id of dos partition table can be changed in this operation e.g.:=

>> when i run command such:
>> sfdisk -d /dev/sda > saved.table
>> sfdisk /dev/sda < saved.table
>> sfdisk -d /dev/sda
>> sfdisk /dev/sda < saved.table
>> sfdisk -d /dev/sda
>> sfdisk /dev/sda < saved.table
>> sfdisk -d /dev/sda
>>
>> each time when i restore partition table label-id of dos type partitio=
n
>> table is changed!
>>
>> For me it is essential that label-id is set exactly as previous becaus=
e
>> after that i restore windows operationg system on this partitions and
>> windows take care about label-id of boot disk partition table
>>
>> Currently i use fdisk (expert option i) for setting label-id of partit=
ion,
>> but why it is not possible thru sfdisk?
> Version? I'm not able to reproduce this problem (v2.28.2 as well as
> upstream tree with incoming v2.30).
root@sysresccd /mnt % sfdisk /dev/sdb < henwar.2017.sdb.sfdisk
Checking that no-one is using this disk right now ... OK

Disk /dev/sdb: 489.1 GiB, 525112713216 bytes, 1025610768 sectors
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

 >>> Script header accepted.
 >>> Script header accepted.
 >>> Script header accepted.
 >>> Script header accepted.
 >>> Created a new DOS disklabel with disk identifier 0x1f257e1a.
Created a new partition 1 of type 'W95 FAT32 (LBA)' and of size 500 MiB.
/dev/sdb2: Created a new partition 2 of type 'HPFS/NTFS/exFAT' and of=20
size 488.6 GiB.
/dev/sdb3:
New situation:

Device     Boot   Start        End    Sectors   Size Id Type
/dev/sdb1  *       2048    1026047    1024000   500M  c W95 FAT32 (LBA)
/dev/sdb2       1026048 1025607679 1024581632 488.6G  7 HPFS/NTFS/exFAT

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

root@sysresccd /mnt % sfdisk -d /dev/sdb
label: dos
label-id: 0x1f257e1a
device: /dev/sdb
unit: sectors

/dev/sdb1 : start=3D        2048, size=3D     1024000, type=3Dc, bootable=

/dev/sdb2 : start=3D     1026048, size=3D  1024581632, type=3D7

root@sysresccd /mnt % less henwar.2017.sdb.sfdisk
label: dos
label-id: 0x908b462c
device: /dev/sdb
unit: sectors

/dev/sdb1 : start=3D        2048, size=3D     1024000, type=3Dc, bootable=

/dev/sdb2 : start=3D     1026048, size=3D  1024581632, type=3D7

root@sysresccd /mnt % sfdisk -v
sfdisk from util-linux 2.28.2

As you see sfdisk creates different label-id than it has in file

>     =20
>         Karel
>
>
> # modprobe scsi_debug dev_size_mb=3D100;
> # echo ',,L' | sfdisk  /dev/sdc
>
>          Disk /dev/sdc: 100 MiB, 104857600 bytes, 204800 sectors
>          Units: sectors of 1 * 512 =3D 512 bytes
>          Sector size (logical/physical): 512 bytes / 512 bytes
>          I/O size (minimum/optimal): 512 bytes / 524288 bytes
>
>          >>> Created a new DOS disklabel with disk identifier 0x6061f50=
2.
>          Created a new partition 1 of type 'Linux' and of size 99 MiB.
>          /dev/sdc2:
>          New situation:
>
>          Device     Boot Start    End Sectors Size Id Type
>          /dev/sdc1        2048 204799  202752  99M 83 Linux
>
> # sfdisk -d /dev/sdc > saved
> # cat saved
>
>          label: dos
>          label-id: 0x6061f502
>          device: /dev/sdc
>          unit: sectors
>
>          /dev/sdc1 : start=3D        2048, size=3D      202752, type=3D=
83
>
>
> # sfdisk  /dev/sdc < saved
>
>          Disk /dev/sdc: 100 MiB, 104857600 bytes, 204800 sectors
>          Units: sectors of 1 * 512 =3D 512 bytes
>          Sector size (logical/physical): 512 bytes / 512 bytes
>          I/O size (minimum/optimal): 512 bytes / 524288 bytes
>          Disklabel type: dos
>          Disk identifier: 0x6061f502
>
>          Old situation:
>
>          Device     Boot Start    End Sectors Size Id Type
>          /dev/sdc1        2048 204799  202752  99M 83 Linux
>
>          >>> Script header accepted.
>          >>> Script header accepted.
>          >>> Script header accepted.
>          >>> Script header accepted.
>          >>> Created a new DOS disklabel with disk identifier 0x6061f50=
2.
>          Created a new partition 1 of type 'Linux' and of size 99 MiB.
>          /dev/sdc2:
>          New situation:
>
>          Device     Boot Start    End Sectors Size Id Type
>          /dev/sdc1        2048 204799  202752  99M 83 Linux
>
> # sfdisk -d /dev/sdc
>
>          label: dos
>          label-id: 0x6061f502
>          device: /dev/sdc
>          unit: sectors
>
>          /dev/sdc1 : start=3D        2048, size=3D      202752, type=3D=
83
>
>
>> Best Regards
>>
>> --=20
>> Bart=C5=82omiej Solarz-Nies=C5=82uchowski, Administrator WSISiZ
>> e-mail: Bartlomiej.Solarz-Niesluchowski@wit.edu.pl
>> tel. 223486547, fax 223486501
>> JID: solarz@jabber.wit.edu.pl
>> 01-447 Warszawa, ul. Newelska 6, pok=C3=B3j 404, pon.-pt. 8-16
>> Motto - Jak sobie po=C5=9Bcielisz tak sie wy=C5=9Bpisz
>>
>>
>
>


--=20
Bart=C5=82omiej Solarz-Nies=C5=82uchowski, Administrator WSISiZ
e-mail: Bartlomiej.Solarz-Niesluchowski@wit.edu.pl
tel. 223486547, fax 223486501
JID: solarz@jabber.wit.edu.pl
01-447 Warszawa, ul. Newelska 6, pok=C3=B3j 404, pon.-pt. 8-16
Motto - Jak sobie po=C5=9Bcielisz tak sie wy=C5=9Bpisz



--------------ms070501070103010702080202
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Kryptograficzna sygnatura S/MIME

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
C3owggWIMIIEcKADAgECAhEAzWOh2VGpX5/p2EoYP+5nTTANBgkqhkiG9w0BAQsFADBpMQsw
CQYDVQQGEwJOTDEWMBQGA1UECBMNTm9vcmQtSG9sbGFuZDESMBAGA1UEBxMJQW1zdGVyZGFt
MQ8wDQYDVQQKEwZURVJFTkExHTAbBgNVBAMTFFRFUkVOQSBQZXJzb25hbCBDQSAyMB4XDTE0
MTAxMzAwMDAwMFoXDTE3MTAxMjIzNTk1OVowggFBMQswCQYDVQQGEwJQTDEUMBIGA1UECBML
TWF6b3dpZWNraWUxETAPBgNVBAcTCFdhcnN6YXdhMQ8wDQYDVQQREwYwMS00NDcxFzAVBgNV
BAkTDnVsLiBOZXdlbHNrYSA2MSAwHgYDVQQLExdMYWJvcmF0b3JpYSBLb21wdXRlcm93ZTE7
MDkGA1UEChMyV3l6c3phIFN6a29sYSBJbmZvcm1hdHlraSBTdG9zb3dhbmVqIGkgWmFyemFk
emFuaWExGTAXBgkqhkiG9w0BCQIWCjg0MEBXU0lTSVoxKjAoBgNVBAMMIUJhcnTFgm9taWVq
IFNvbGFyei1OaWVzxYJ1Y2hvd3NraTE5MDcGCSqGSIb3DQEJARYqQmFydGxvbWllai5Tb2xh
cnotTmllc2x1Y2hvd3NraUB3aXQuZWR1LnBsMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAlwAAoBfN0M9lTNyF1C51YFnVsVSOP4lH0fZnu4kQacKGtOuO04K995P8Q4l3kTaT
zJVBPfZpm+im5ghVQNDKWmR8cVvMzFlnvmEjTzPrj4i4uf7sz4BFMJV9x7rlBWOC6quBsGIi
xIcDTZ3dgKZmXkzl/EEiPRH0Ng7kwRdXWPCtwbe7pOcPtrM7BkRSGPy6N5unv2m4f2nb7UZ9
kgni49NlMyPrDlhGufhmYvZ6wPXVnGlYlGl+3n44Gj3cUMa3XhV5jyjv94HZEcLmqVv3zPHz
JB4egj7eXDwjHdnC7jSxEw9CctrVhk5h9XHk26P6f44ZwBPF3eT01J+6/A0TYwIDAQABo4IB
TzCCAUswHwYDVR0jBBgwFoAU+5w4I1Ch1wAEmS04BmSQoyYb2+0wHQYDVR0OBBYEFCEtceIk
iaeUVAZyD081M6c1QRKuMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQW
MBQGCCsGAQUFBwMEBggrBgEFBQcDAjAYBgNVHSAEETAPMA0GCysGAQQBsjEBAgIdMD8GA1Ud
HwQ4MDYwNKAyoDCGLmh0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9URVJFTkFQZXJzb25hbENB
Mi5jcmwwcQYIKwYBBQUHAQEEZTBjMDoGCCsGAQUFBzAChi5odHRwOi8vY3J0LnVzZXJ0cnVz
dC5jb20vVEVSRU5BUGVyc29uYWxDQTIuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51
c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQAW1pKjXAk7o2w1jjCxSOfMT7DOjwzO
t6GJImAaBUsczhIYRuzyCegTN7l8FmIEF78AjkHrCwM8zZKEDzc+JzS3qVS7DMFlUNBpiDM4
RZmoqv2gHqkR3/j8+MCP3Du9ZXEgd40cVfWcl4bbpB2FjVm879oET6HxhuFNHYa8Sprs56TF
ANvrn/EjP3hB5BbrHveCbn1M2dSEhl9ojG9YxEmR5k6ooRqGy4LdLTdTOO1iXW42+JFdTKLY
K27cePtzVAZkzzBZLH8rZ2mrC+rwU3EuFXYQDiKRsah+FvLpF55brFBtG8BlIlYMoZrwb8FG
ZxzBtH2NZTEypppmhKntf17dMIIF6jCCA9KgAwIBAgIRAM0n6PuHVxFfdlSNZoQ9l/owDQYJ
KoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYD
VQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYD
VQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTE0MTAwOTAw
MDAwMFoXDTI0MTAwODIzNTk1OVowaTELMAkGA1UEBhMCTkwxFjAUBgNVBAgTDU5vb3JkLUhv
bGxhbmQxEjAQBgNVBAcTCUFtc3RlcmRhbTEPMA0GA1UEChMGVEVSRU5BMR0wGwYDVQQDExRU
RVJFTkEgUGVyc29uYWwgQ0EgMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIt/
txlfYTgQu/SsFvalu41zNJsnlZV8L2L22pUwZyCfFo+Y1TUhlh6+3ppy8iN53w4L8oIOeJtW
dlTTCG2cstFjVMDPGDt5qSZg2J/+p5SsClYDkuRhLd2JhKm0XTzF2Xk+G5fSLS4fp9gD2fCu
a7yqFU6vcr2OKpCBuK+sNQgwagGZHUhR92hxhmGYihsg7JbCqv5sGEOclH+2i34wqbxVbOtX
B3rTHkLjuqVTC+rY7/fUz5GKDnraaVq56unRxerjmLKGTNwHcL+tlC4H1RMqkcxukrljaVPQ
nWhJYp0rSvRfwlFJGgTNHUvt/jmjqsVfqwzssyLHU3mJAkTxl70CAwEAAaOCAWswggFnMB8G
A1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBT7nDgjUKHXAASZLTgG
ZJCjJhvb7TAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAU
BggrBgEFBQcDAgYIKwYBBQUHAwQwGAYDVR0gBBEwDzANBgsrBgEEAbIxAQICHTBQBgNVHR8E
STBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNFUlRydXN0UlNBQ2VydGlm
aWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEEajBoMD8GCCsGAQUFBzAChjNodHRw
Oi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRydXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYB
BQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAECZ
vR9W7r9ievG4g95FRUr9M/saDMcLJonWtk1pFoO4jkJyTBryic4xo+DBk48fW92GukiUQEIc
NGkhGPVMfYFTwp7Cue8yjjyoKMDpJMVx/72iJA0tL+LXbGgedtxxKXGMf1EsE97nDy4xCrer
iELxXBPqt8x9Wscs9go/1uPW4laDLVT/RwQiiGDx/UNZb1ev6RKtRAg6y+Anp5Yd6AUf2/6c
aQ8H9tjrcxZ6nsiNcc5DrFx4hK2KTqZAVfud8HCmBR0ic4WtbRFBd65HKCx5AcN+Usc9I48M
F+7Ohz2ZJSDiAVmNwrMYFTX5cHBTD9Nt26TezyuKQEooR1hx2ODxQqnT+xXOiJxxltZgw4dh
9RT/fyEaIhAFmqJCaTGYqCnVED2MDYTiWJeZ8Ag6qCk99Aqou49IMOiZNdWQCHw97qFlx8Xh
Tc4RfxSFqhYpK1Kb6DouDmuwmRPT0MWuRZNs2fTumA3b08klQkLK0f+OEFJWVAWyRSfWvS/6
v8XPNxzOgtbiSjAX1vixM/5lrNei6JlmJjhgODr+X7ydaAddhvzu5p6hqIsmLRNPoRZkumfj
ppoVkX/X8SSkMg7a6mMXDjl3o4vOD0A8sZ4t/TZTkhXSdxxy2kO8zBk3HOvNnc9JgekNS8ki
K3OaBG7Vv2CPyc0vknfcyGVhzBOAnishMYIDqDCCA6QCAQEwfjBpMQswCQYDVQQGEwJOTDEW
MBQGA1UECBMNTm9vcmQtSG9sbGFuZDESMBAGA1UEBxMJQW1zdGVyZGFtMQ8wDQYDVQQKEwZU
RVJFTkExHTAbBgNVBAMTFFRFUkVOQSBQZXJzb25hbCBDQSAyAhEAzWOh2VGpX5/p2EoYP+5n
TTANBglghkgBZQMEAgEFAKCCAfswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMTcwMjIxMTY1ODEyWjAvBgkqhkiG9w0BCQQxIgQgdz6k0VfHq370CZwe1mqi
cJkgvY9ntD2b9SyRqb3ViOswbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASowCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUr
DgMCBzANBggqhkiG9w0DAgIBKDCBjgYJKwYBBAGCNxAEMYGAMH4waTELMAkGA1UEBhMCTkwx
FjAUBgNVBAgTDU5vb3JkLUhvbGxhbmQxEjAQBgNVBAcTCUFtc3RlcmRhbTEPMA0GA1UEChMG
VEVSRU5BMR0wGwYDVQQDExRURVJFTkEgUGVyc29uYWwgQ0EgMgIRAM1jodlRqV+f6dhKGD/u
Z00wgZAGCyqGSIb3DQEJEAILMYGAoH4waTELMAkGA1UEBhMCTkwxFjAUBgNVBAgTDU5vb3Jk
LUhvbGxhbmQxEjAQBgNVBAcTCUFtc3RlcmRhbTEPMA0GA1UEChMGVEVSRU5BMR0wGwYDVQQD
ExRURVJFTkEgUGVyc29uYWwgQ0EgMgIRAM1jodlRqV+f6dhKGD/uZ00wDQYJKoZIhvcNAQEB
BQAEggEAedR2vAi3NyculCnx8aXQNvu9z6cN0yDBvWmRgeWgH+k6Nw0PTzyXKz4L58SWSO/m
e42Xwc18ggsfebXpXDLn19nMEcKypTWSgpzBrnGTYWqfTtvgwSV3XSwiKhuqOnwlIVYUw0RH
bLMvXeE2LFJsPiqfI8wQ5+eMJBxQTT40D5aUBbTAgCoP9JMbkN6wMLiSBdDZbVe8kh+fJKcF
JEwrMK+JyDW14oIuFjOu81gLjRCSVh66B5l9TkCNNdxhp46XTSj7iMmIOGJUzU3QbVKmEfAm
GvIUGyGLPqc8deC9KB0T6YUB2I8vejWvOZ916J0PCi85QgsXgl7YGc9rHHgDlAAAAAAAAA==
--------------ms070501070103010702080202--
