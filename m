Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:18480 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751631AbaL2BaC (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 28 Dec 2014 20:30:02 -0500
Message-ID: <54A0AE98.70503@ubuntu.com>
Date: Sun, 28 Dec 2014 20:30:00 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: libsmartcols patch
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hHkqQeEfS8TSbdLcUh2PStN78ugEGb52C"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hHkqQeEfS8TSbdLcUh2PStN78ugEGb52C
Content-Type: multipart/mixed;
 boundary="------------060501000801040802070904"

This is a multi-part message in MIME format.
--------------060501000801040802070904
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Forwarding patch from https://launchpad.net/bugs/1406133:


--------------060501000801040802070904
Content-Type: text/x-patch;
 name="libsmartcols-art-fix.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="libsmartcols-art-fix.diff"

--- libsmartcols/src/table_print.c	2014-12-24 23:59:55.780110296 +0200
+++ libsmartcols/src/table_print.c	2014-12-28 22:45:20.347285226 +0200
@@ -151,6 +151,32 @@
 	return bytes;
 }
=20
+/* returns pointer to the end of used data */
+static int line_ascii_art_to_buffer(struct libscols_table *tb,
+				    struct libscols_line *ln,
+				    struct libscols_buffer *buf)
+{
+	const char *art;
+	int rc;
+
+	assert(ln);
+	assert(buf);
+
+	if (!ln->parent)
+		return 0;
+
+	rc =3D line_ascii_art_to_buffer(tb, ln->parent, buf);
+	if (rc)
+		return rc;
+
+	if (list_entry_is_last(&ln->ln_children, &ln->parent->ln_branch))
+		art =3D "  ";
+	else
+		art =3D tb->symbols->vert;
+
+	return buffer_append_data(buf, art);
+}
+
 #define is_last_column(_tb, _cl) \
 		list_entry_is_last(&(_cl)->cl_columns, &(_tb)->tb_columns)
=20
@@ -258,8 +284,33 @@
 		if (len > width && !scols_column_is_trunc(cl)) {
 			fputs(linesep(tb), tb->out);
 			for (i =3D 0; i <=3D (size_t) cl->seqnum; i++) {
-				struct libscols_column *x =3D scols_table_get_column(tb, i);
-				fprintf(tb->out, "%*s ", -((int)x->width), " ");
+				size_t len_pad =3D 0;	/* in screen cells as opposed to bytes */
+				struct libscols_column* cl_pad =3D scols_table_get_column(tb, i);
+				if(ln && scols_column_is_tree(cl_pad)) {
+					if (!ln->parent) {	/* Root cell needs special treatment. */
+						if (!list_empty(&ln->ln_branch)) {	/* only print symbols->vert if =
followed by something */
+							fputs(tb->symbols->vert, tb->out);
+							len_pad =3D mbs_safe_width(tb->symbols->vert);
+						}
+					} else {	/* use the same draw function as though we were intending =
to draw an L-shape */
+						struct libscols_buffer* b_art =3D new_buffer(1024);	/* TODO: FIXME=
 proper size */
+						char* data =3D 0;
+
+						if(b_art) {
+							line_ascii_art_to_buffer(tb, ln, b_art);	/* whatever the rc, len_=
pad will be sensible */
+							data =3D buffer_get_safe_data(b_art, &len_pad);
+							if(data && len_pad) {
+								fputs(data, tb->out);
+							}
+
+							free_buffer(b_art);
+						}
+					}
+				}
+				for(; len_pad <=3D cl_pad->width; ++len_pad)
+				{
+					fputc(' ', tb->out);
+				}
 			}
 		} else
 			fputs(colsep(tb), tb->out);	/* columns separator */
@@ -268,32 +319,6 @@
 	return 0;
 }
=20
-/* returns pointer to the end of used data */
-static int line_ascii_art_to_buffer(struct libscols_table *tb,
-				    struct libscols_line *ln,
-				    struct libscols_buffer *buf)
-{
-	const char *art;
-	int rc;
-
-	assert(ln);
-	assert(buf);
-
-	if (!ln->parent)
-		return 0;
-
-	rc =3D line_ascii_art_to_buffer(tb, ln->parent, buf);
-	if (rc)
-		return rc;
-
-	if (list_entry_is_last(&ln->ln_children, &ln->parent->ln_branch))
-		art =3D "  ";
-	else
-		art =3D tb->symbols->vert;
-
-	return buffer_append_data(buf, art);
-}
-
 static int cell_to_buffer(struct libscols_table *tb,
 			  struct libscols_line *ln,
 			  struct libscols_column *cl,

--------------060501000801040802070904--

--hHkqQeEfS8TSbdLcUh2PStN78ugEGb52C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJUoK6YAAoJENRVrw2cjl5R9ckH/1UUOiCiMTygU4oAM+wQl8ZO
GZcDdaOdWunbPgQHPvTZvgh9ixChPlfeITzTsrt6w0I4hpJ8v77G7rptiKfy1m10
io+y7eT1GrtCVQzpgvSuSt1kqNI9Wm8A3PsCNViW8IKMkZlb6KBjysBakdDO28xR
Kk2kUvBCUjsn+AFPDFqi2w8bkbvTpBgFwdEKzrusekezdsuDxGSYpoMsCrCnEQjn
OGshwwZka15iBqFgqhrk3oYmUJIICb0aKKYXhw8w6xIqpra/MUQrll3SnGgmCOfW
Y7P0fPWVBT/QIim0HAHvfcbgsXCPv3oUxtO+BXwOcC0dl/x8UqF03Y9vsHfyseY=
=KJRk
-----END PGP SIGNATURE-----

--hHkqQeEfS8TSbdLcUh2PStN78ugEGb52C--
