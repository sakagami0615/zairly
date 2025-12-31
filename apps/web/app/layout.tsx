import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Zairly - AI在庫管理",
  description: "チャットで簡単に在庫を管理",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="ja">
      <body>{children}</body>
    </html>
  );
}
